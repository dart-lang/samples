// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Read the file, spawn an isolate, send the file contents to the spawned
// isolate, and wait for the parsed JSON.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

const filename = 'json_01.json';

Future<void> main() async {
  final filename = 'json_01.json';
  final jsonData = await _spawnAndReceive(filename);
  print('Received JSON with ${jsonData.length} keys');
}

// Spawns an isolate and sends a [filename] as the first message.
// Waits to receive a message from the the spawned isolate containing the
// parsed JSON.
Future<Map<String, dynamic>> _spawnAndReceive(String fileName) async {
  final p = ReceivePort();
  await Isolate.spawn(_readAndParseJson, [p.sendPort, fileName]);
  return (await p.first) as Map<String, dynamic>;
}

// The entrypoint that runs on the spawned isolate. Reads the contents of
// fileName, decodes the JSON, and sends the result back to the main
// isolate.
void _readAndParseJson(List<dynamic> args) async {
  SendPort responsePort = args[0];
  String fileName = args[1];

  final fileData = await File(fileName).readAsString();
  final result = jsonDecode(fileData);
  Isolate.exit(responsePort, result);
}
