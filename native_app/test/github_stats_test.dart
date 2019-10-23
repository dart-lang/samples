// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:github/server.dart';
import 'package:native_app/src/formatter.dart';
import 'package:test/test.dart';

void main() {
  test('DefaultFormatter', () {
    var formatter = DefaultEventFormatter();
    var actor = Actor()..login = 'substack';

    var event = Event()
      ..createdAt = DateTime.utc(2019, 10, 1, 12)
      ..type = 'PullRequestEvent'
      ..payload = {
        'action': 'closed',
        'pull_request': {
          'html_url': 'https://github.com/peermaps/random-slicing/issues/2'
        }
      }
      ..actor = actor;
    var output = formatter.format(event);
    // Don't check exact date since it is formatted as local time.
    expect(output, contains('Tuesday, October 1 at '));
    expect(
        output,
        contains(
            'substack closed https://github.com/peermaps/random-slicing/issues/2'));
  });
}
