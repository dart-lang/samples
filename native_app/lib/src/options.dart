import 'package:build_cli_annotations/build_cli_annotations.dart';

part 'options.g.dart';

ArgParser get parser => _$populateOptionsParser(ArgParser(usageLineLength: 80));

@CliOptions()
class Options {
  @CliOption(abbr: 'u', help: 'GitHub user to fetch status')
  String user;

  @CliOption(
    abbr: 'i',
    help: 'The time interval to filter events.',
    allowed: ['day', 'week', 'month'],
  )
  Interval interval;

  @CliOption(abbr: 'v', help: 'Print additional event types')
  final bool verbose;

  @CliOption(abbr: 'h', negatable: false, help: 'Prints usage information.')
  final bool help;

  Options(this.user, this.interval, this.verbose, this.help);
}

enum Interval {
  day,
  week,
  month,
}
