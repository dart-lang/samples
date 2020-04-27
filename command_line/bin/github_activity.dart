// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:cli_app/github_activity.dart';
import 'package:cli_app/src/formatter.dart';

void main(List<String> args) {
  var options = parseOptions(args);

  if (options.help) {
    _printUsage();
    return;
  }

  if (options.user == null || options.user.isEmpty) {
    _printUsage();
    return;
  }

  var fetcher = ActivityService(options.user, options.verbose, options.interval,
      formatter: _getFormatter(options));

  // Stream the github activity to the console
  fetcher.getActivityStrings().listen((s) {
    print(s);
  })
    ..onDone(() => exit(0))
    ..onError((e) => print('Unable to fetch stats:\n$e'));
}

/// Gets the correct [Formatter] defined by [Options]
EventFormatter _getFormatter(Options options) {
  if (options.format == 'markdown') {
    return MarkdownEventFormatter();
  }
  return DefaultEventFormatter();
}

void _printUsage() {
  print('''
A command line utility for fetching a GitHub user's recent activity.

Usage: github_activity [<args>]

Arguments:
${parser.usage}
''');
}
