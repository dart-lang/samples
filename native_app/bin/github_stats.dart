import 'package:native_app/github_stats.dart';

void main(List<String> args) {
  var options = parseOptions(args);
  if (options.help) {
    _printUsage();
    return;
  }
  try {
    fetchUserStats(options.user, options.verbose, options.interval);
  } on FetchStatsException catch (e) {
    print('Unable to fetch stats');
    print(e);
  }
}

void _printUsage() {
  print('''
Usage: github_stats [<args>]

Arguments:
${parser.usage}
''');
}
