// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

void main() {
  test('starts server and responds to root endpoint', () async {
    const port = 8092;
    final process = await TestProcess.start(
      Platform.resolvedExecutable,
      ['bin/server.dart'],
      environment: {'PORT': port.toString()},
    );

    // Wait for the server to announce it is listening.
    await expectLater(
      process.stdout,
      emitsThrough(contains('Serving at http://')),
    );

    final baseUrl = Uri(scheme: 'http', host: '127.0.0.1', port: port);
    final client = http.Client();
    try {
      final response = await client.get(baseUrl);
      expect(response.statusCode, equals(200));

      final data = jsonDecode(response.body) as Map<String, Object?>;
      expect(data['service'], equals('Google Cloud Storage Dart Demo'));
      expect(data['bucketConfigured'], isFalse);
    } finally {
      client.close();
      process.signal(ProcessSignal.sigterm);
      await process.shouldExit();
    }
  });

  test('reports clear error when bucket is not configured', () async {
    const port = 8093;
    final process = await TestProcess.start(
      Platform.resolvedExecutable,
      ['bin/server.dart'],
      environment: {'PORT': port.toString()},
    );

    // Wait for the server to announce it is listening.
    await expectLater(
      process.stdout,
      emitsThrough(contains('Serving at http://')),
    );

    final baseUrl = Uri(scheme: 'http', host: '127.0.0.1', port: port);
    final client = http.Client();
    try {
      final response = await client.get(baseUrl.resolve('files'));
      expect(response.statusCode, equals(400));

      final data = jsonDecode(response.body) as Map<String, Object?>;
      expect(data['error'], contains('STORAGE_BUCKET'));
    } finally {
      client.close();
      process.signal(ProcessSignal.sigterm);
      await process.shouldExit();
    }
  });
}
