// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Spawn an isolate, read multiple files, send their contents to the spawned
// isolate, and wait for the parsed JSON.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:async/async.dart';

const filenames = [
  'json_01.json',
  'json_02.json',
  'json_03.json',
];

// Reads multiple files and parses them on a separate isolate.
void main() async {
  // Read some data.
  final fileData = await _readFiles();

  // Print incoming events from the spawned isolate
  await for (final jsonData in _parseJsonStrings(fileData)) {
    print('Received JSON with ${jsonData.length} keys');
  }
}

// Reads multiple files simultaneously using Future.wait().
Future<List<String>> _readFiles() async {
  return await Future.wait([
    ...filenames.map((f) => File(f)).map((file) => file.readAsString()),
  ]);
}

// Sends strings to a separate isolate
//
// Returns a stream that emits events, where the event value the parsed JSON
Stream<Map<String, dynamic>> _parseJsonStrings(
    List<String> jsonStrings) async* {
  final p = ReceivePort();
  await Isolate.spawn(_receiveAndParseJsonService, p.sendPort);

  // Send each JSON string in order, waiting for the previous result before
  // sending the next JSON string.
  final events = StreamQueue<dynamic>(p);
  SendPort sendPort = await events.next;

  for (var jsonString in jsonStrings) {
    // Send the next JSON string to be parsed
    sendPort.send(jsonString);

    // Receive the parsed JSON
    Map<String, dynamic> message = await events.next;

    // Add the result to the stream returned by this async* function.
    yield message;
  }

  // Send a signal to the spawned isolate indicating that it should exit.
  sendPort.send(null);

  // Dispose the StreamQueue
  await events.cancel();
}

// The function runs on the spawned isolate. Waits for incoming strings and
// sends the decoded JSON using the SendPort.
Future<void> _receiveAndParseJsonService(SendPort p) async {
  print('Spawned isolate started.');
  // Send a SendPort to the main isolate so that it can send JSON strings to
  // this isolate.
  final commandPort = ReceivePort();
  p.send(commandPort.sendPort);

  // Wait for messages from the main isolate.
  await for (final message in commandPort) {
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
