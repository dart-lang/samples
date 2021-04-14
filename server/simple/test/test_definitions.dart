// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:http/http.dart';
import 'package:test/test.dart';

void runTests(
  void Function(String name, Future<void> Function(String host)) testServer,
) {
  testServer('root', (host) async {
    final response = await get(Uri.parse(host));
    expect(response.statusCode, 200);
    expect(response.body, 'Hello, World!');
  });

  testServer('time', (host) async {
    final response = await get(Uri.parse('$host/time'));
    expect(response.statusCode, 200);
    final serverTime = DateTime.parse(response.body);
    final now = DateTime.now();
    expect(
      !serverTime.isAfter(now),
      isTrue,
      reason: 'Server time ($serverTime) should not be after current time '
          'after server time ($now).',
    );
  });

  testServer('404', (host) async {
    var response = await get(Uri.parse('$host/not_here'));
    expect(response.statusCode, 404);
    expect(response.body, 'Not Found');

    response = await post(Uri.parse('$host'));
    expect(response.statusCode, 404);
    expect(response.body, 'Not Found');
  });
}
