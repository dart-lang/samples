import 'dart:io';

import 'package:github/server.dart';
import 'package:intl/intl.dart';

import 'src/options.dart';

export 'src/options.dart';

final dateFormat = DateFormat("yyyy.MM.dd G 'at' HH:mm:ss");

Authentication get authentication {
  var ghStatsToken = Platform.environment['GH_STATS_TOKEN'];
  return Authentication.withToken(ghStatsToken);
}

Future fetchUserStats(String username, bool verbose, Interval interval) async {
  try {
    await _fetchUserStatsImpl(username, verbose, interval);
  } catch (e) {
    throw FetchStatsException('failed to fetch stats for user $username $e');
  }
}

Future _fetchUserStatsImpl(
    String username, bool verbose, Interval interval) async {
  var client = createGitHubClient(auth: authentication);
  var events =
      await client.activity.listEventsPerformedByUser(username).toList();

  for (var event in events) {
    if (isTooOld(event.createdAt, interval)) {
      continue;
    }
    _printEvent(event, verbose);
  }
}

bool isTooOld(DateTime date, Interval interval) {
  switch (interval) {
    case Interval.day:
      return date.isBefore(DateTime.now().subtract(Duration(days: 1)));
    case Interval.week:
      return date.isBefore(DateTime.now().subtract(Duration(days: 7)));
    case Interval.month:
      return date.isBefore(DateTime.now().subtract(Duration(days: 30)));
    default:
      return true;
  }
}

void _printEvent(Event event, bool verbose) {
  var date = dateFormat.format(event.createdAt.toLocal());
  var action = actionFromEvent(event);
  print('$date: $action');
}

String actionFromEvent(Event event) {
  var type = event.type;
  var username = event.actor.login;
  if (type == 'PullRequestEvent') {
    var pullRequest = event.payload['pull_request']['url'];
    var action = event.payload['action'];
    return '$username $action $pullRequest';
  }
  return '[$type]';
}

class FetchStatsException implements Exception {
  final String message;

  FetchStatsException(this.message);

  String toString() => message;
}
