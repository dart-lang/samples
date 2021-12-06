// Read the file, spawn an isolate, send the file contents to the spawned
// isolate, and wait for the parsed JSON.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

final filename = 'citylots.json';

Future<void> main() async {
  // Read some data.
  final fileData = await File(filename).readAsString();
  final jsonData = await _spawnIsolateAndSendJson(fileData);

  // Use that data.
  print('Received JSON with ${jsonData.length} keys');
}

// Sends a JSON string to the spawned isolate to be parsed.
Future<Map<String, dynamic>> _spawnIsolateAndSendJson(
    String jsonString) async {
  final p = ReceivePort();
  await Isolate.spawn(_receiveAndParseJson, p.sendPort);
  await for (final message in p) {
    // The spawned isolate will first send a SendPort, and then it will send
    // the parsed JSON. If it sends a SendPort, use it to send the JSON string.
    if (message is SendPort) {
      message.send(jsonString);
    } else {
      return message;
    }
  }
  return {};
}

Future _receiveAndParseJson(SendPort p) async {
  final rp = ReceivePort();

  // Send a port back to the main isolate. This port is used to send the JSON
  // string.
  p.send(rp.sendPort);

  final jsonString = await rp.first;
  Isolate.exit(p, jsonDecode(jsonString));
}
