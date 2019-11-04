// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:github/github.dart';

import 'options.dart';

String getAction(Event event) {
  return event.payload['action'];
}

String getUrl(Event event) {
  var type = event.type;

  if (type == 'PullRequestEvent') {
    return event.payload['pull_request']['html_url'];
  }

  if (type == 'IssuesEvent') {
    return event.payload['issue']['html_url'];
  }

  return null;
}

String getTitle(Event event) {
  var type = event.type;

  if (type == 'PullRequestEvent') {
    return event.payload['pull_request']['title'];
  }

  if (type == 'IssuesEvent') {
    return event.payload['issue']['title'];
  }

  return null;
}

int getIssueNumber(Event event) {
  var type = event.type;

  if (type == 'PullRequestEvent') {
    return event.payload['pull_request']['number'];
  }

  if (type == 'IssuesEvent') {
    return event.payload['issue']['number'];
  }

  return null;
}

bool isTooOld(DateTime date, Interval interval) {
  var now = DateTime.now();
  switch (interval) {
    case Interval.day:
      return date.isBefore(now.subtract(Duration(days: 1)));
    case Interval.week:
      return date.isBefore(now.subtract(Duration(days: 7)));
    case Interval.month:
      return date.isBefore(now.subtract(Duration(days: 30)));
    default:
      return true;
  }
}
