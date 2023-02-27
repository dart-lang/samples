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
  // Read and parse JSON data in a new isolate,
  // then store the returned Dart representation.
  final jsonData = await Isolate.run(() => _readAndParseJson(filename));

  print('Received JSON with ${jsonData.length} keys');
}

/// Reads the contents of the file with [filename],
/// decodes the JSON, and returns the result.
Future<Map<String, dynamic>> _readAndParseJson(String filename) async {
  final fileData = await File(filename).readAsString();
  final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
  return jsonData;
}
