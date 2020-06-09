// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:github/github.dart';

import 'src/formatter.dart';
import 'src/options.dart';
import 'src/util.dart' as util;

export 'src/options.dart';

/// Returns the value of the `GITHUB_TOKEN` environment variable. This
/// variable should contain a GitHub auth token. Auth tokens are used to avoid
/// API rate-limiting.
Authentication get authentication {
  var ghStatsToken = Platform.environment['GITHUB_TOKEN'];
  return Authentication.withToken(ghStatsToken);
}

/// Returns the activity for a given GitHub user, formatted using the provided
/// [formatter].
class ActivityService {
  final String username;
  final bool verbose;
  final Interval interval;
  final EventFormatter formatter;
  static const _supportedEventTypes = ['PullRequestEvent', 'IssuesEvent'];

  ActivityService(this.username, this.verbose, this.interval,
      {this.formatter = const DefaultEventFormatter()});

  /// Returns a stream of formatted lines for printing to the console.
  Stream<String> getActivityStrings() async* {
    var stream = _fetchUserStatsImpl();

    try {
      await for (var s in stream) {
        yield s;
      }
    } catch (e) {
      throw GetActivityException(username, e);
    }
  }

  Stream<String> _fetchUserStatsImpl() async* {
    var client = GitHub(auth: authentication);
    var events = client.activity.listEventsPerformedByUser(username);

    await for (var event in events) {
      if (util.isTooOld(event.createdAt, interval)) {
        return;
      }

      if (_isSupported(event) || verbose) {
        yield formatter.format(event);
      }
    }
  }

  bool _isSupported(Event event) {
    return _supportedEventTypes.contains(event.type);
  }
}

/// Thrown when this package fails to get the user's activity
class GetActivityException implements Exception {
  final String username;
  final Object original;

  GetActivityException(this.username, this.original);

  @override
  String toString() => 'failed to fetch stats for user $username: $original';
}
