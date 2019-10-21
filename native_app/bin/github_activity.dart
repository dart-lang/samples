import 'dart:io';
import 'package:native_app/github_activity.dart';
import 'package:native_app/src/formatter.dart';

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

  fetcher.getActivityStrings().listen((s) {
    print(s);
  })
    ..onDone(() => exit(0))
    ..onError((e) => print('Unable to fetch stats:\n$e'));
}

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
