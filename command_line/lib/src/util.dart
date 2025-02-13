// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:github/github.dart';

import 'options.dart';

String? extractAction(Event event) => event.payload!['action'];

String? extractUrl(Event event) => switch (event.type) {
  'PullRequestEvent' => event.payload!['pull_request']['html_url'],
  'IssuesEvent' => event.payload!['issue']['html_url'],
  _ => null,
};

String? extractTitle(Event event) => switch (event.type) {
  'PullRequestEvent' => event.payload!['pull_request']['title'],
  'IssuesEvent' => event.payload!['issue']['title'],
  _ => null,
};

int? extractIssueNumber(Event event) => switch (event.type) {
  'PullRequestEvent' => event.payload!['pull_request']['number'],
  'IssuesEvent' => event.payload!['issue']['number'],
  _ => null,
};

bool isTooOld(DateTime? date, Interval interval) =>
    date?.isBefore(DateTime.now().subtract(interval.duration)) ?? true;
