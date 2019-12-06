// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

T _$enumValueHelper<T>(Map<T, String> enumValues, String source) {
  if (source == null) {
    return null;
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

Options _$parseOptionsResult(ArgResults result) => Options(
    result['user'] as String,
    _$enumValueHelper(_$IntervalEnumMap, result['interval'] as String),
    result['verbose'] as bool,
    result['format'] as String,
    result['help'] as bool);

const _$IntervalEnumMap = <Interval, String>{
  Interval.day: 'day',
  Interval.week: 'week',
  Interval.month: 'month'
};

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addOption('user', abbr: 'u', help: 'Required. The GitHub user')
  ..addOption('interval',
      abbr: 'i',
      help: 'The time interval to filter events.',
      defaultsTo: 'week',
      allowed: ['day', 'week', 'month'])
  ..addFlag('verbose', abbr: 'v', help: 'Print additional event types')
  ..addOption('format',
      abbr: 'f',
      help:
          'The format to display. Defaults to "Friday, October 18 at 13:55 PM: <User> opened <URL>"',
      allowed: [
        'default',
        'markdown'
      ])
  ..addFlag('help',
      abbr: 'h', help: 'Prints usage information.', negatable: false);

final _$parserForOptions = _$populateOptionsParser(ArgParser());

Options parseOptions(List<String> args) {
  final result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
