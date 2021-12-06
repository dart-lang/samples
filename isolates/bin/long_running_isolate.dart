// Spawn an isolate, read multiple files, send their contents to the spawned
// isolate, and wait for the parsed JSON.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

final fileNames = [
  'json_01.json',
  'json_02.json',
  'json_03.json',
];

// Reads multiple files and parses them on a separate isolate.
Future<void> main() async {
  // Read some data.
  final fileData = await _readFiles();

  // Use that data.
  await for (final jsonData in _parseJsonStrings(fileData)) {
    print('Received JSON with ${jsonData.length} keys');
  }
}

// Reads multiple files simultaneously using Future.wait().
Future<List<String>> _readFiles() async {
  return await Future.wait([
    ...fileNames.map((f) => File(f)).map((file) => file.readAsString()),
  ]);
}

// Sends multiple JSON strings to a separate isolate.
Stream<Map<String, dynamic>> _parseJsonStrings(
    List<String> jsonStrings) async* {
  final p = ReceivePort();
  await Isolate.spawn(_receiveAndParseJsonService, p.sendPort);

  // Send each JSON string in order, waiting for the previous result before
  // sending the next JSON string.
  var i = 0;

  // The port used to send JSON strings to be parsed.
  // This is the first message sent by the spawned isolate.
  late final SendPort sendPort;

  // Receive messages from the spawned isolate
  await for (final message in p) {
    if (message is SendPort) {
      // This is the first message, assign the sendPort
      sendPort = message;
    } else if (message is Map<String, dynamic>) {
      // This is a response, add it to the Stream returned by this function.
      yield message;
    }

    // Send the next JSON string to be parsed.
    if (i < jsonStrings.length) {
      sendPort.send(jsonStrings[i++]);
    } else {
      // Send the final message to indicate that the spawned isolate should
      // exit.
      sendPort.send(null);
      break;
    }
  }
}

// The function runs on the spawned isolate. Waits for incoming strings and
// sends the decoded JSON using the SendPort.
Future<void> _receiveAndParseJsonService(SendPort p) async {
  // Send a SendPort to the main isolate so that it can send JSON strings to
  // this isolate.
  final rp = ReceivePort();
  p.send(rp.sendPort);

  // Wait for messages from the main isolate.
  await for (final message in rp) {
    if (message is String) {
      p.send(jsonDecode(message));
    } else if (message == null) {
      // Exit if the main isolate sends a null message, indicating there are no
      // more strings to parse.
      break;
    }
  }
  print('Spawned isolate finished.');
  Isolate.exit();
}
