// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

void main() {
  test('starts server and responds to requests', () async {
    const port = 8091;
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
      final rootResponse = await client.get(baseUrl);
      expect(rootResponse.statusCode, equals(200));
      expect(
        jsonDecode(rootResponse.body),
        equals({'message': 'Hello from Cloud Run with Dart!'}),
      );

      final healthResponse = await client.get(baseUrl.resolve('healthz'));
      expect(healthResponse.statusCode, equals(200));
      expect(jsonDecode(healthResponse.body), equals({'status': 'healthy'}));
    } finally {
      client.close();
      process.signal(ProcessSignal.sigterm);
      await process.shouldExit();
    }
  });
}
