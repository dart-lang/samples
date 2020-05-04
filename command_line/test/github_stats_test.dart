// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:github/github.dart';
import 'package:cli_app/src/formatter.dart';
import 'package:test/test.dart';

void main() {
  test('DefaultFormatter', () {
    var formatter = DefaultEventFormatter();
    var actor = User()..login = 'substack';
    var org = Organization();
    var repo = Repository();

    var event = Event(
      id: '',
      type: 'PullRequestEvent',
      createdAt: DateTime.utc(2019, 10, 1, 12),
      actor: actor,
      payload: {
        'action': 'closed',
        'pull_request': {
          'html_url': 'https://github.com/peermaps/random-slicing/issues/2'
        },
      },
      org: org,
      repo: repo,
    );

    var output = formatter.format(event);
    // Don't check exact date since it is formatted as local time.
    expect(output, contains('Tuesday, October 1 at '));
    expect(
        output,
        contains(
            'substack closed https://github.com/peermaps/random-slicing/issues/2'));
  });
}
