// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:github/github.dart';
import 'package:intl/intl.dart';
import 'util.dart' as util;

/// Formats an [Event] for console output.
abstract class EventFormatter {
  String format(Event event);
}

/// Returns a formatted string of the form `Friday, October 18 at 13:55 PM:
/// <User> opened <URL>`.
class DefaultEventFormatter implements EventFormatter {
  static final dateFormat = DateFormat("EEEE, MMMM d 'at' HH:mm a");

  const DefaultEventFormatter();

  @override
  String format(Event event) {
    var date = dateFormat.format(event.createdAt.toLocal());
    var type = event.type;
    var username = event.actor.login;
    var url = util.getUrl(event);
    if (url == null) {
      return '$date: [$type]';
    }
    var action = util.getAction(event);

    return '$date: $username $action $url';
  }
}

class MarkdownEventFormatter implements EventFormatter {
  static final dateFormat = DateFormat('EEE, M/d/y');
  @override
  String format(Event event) {
    var date = dateFormat.format(event.createdAt.toLocal());
    var type = event.type;
    var action = util.getAction(event);
    var url = util.getUrl(event);
    if (url == null) {
      return '- ($date): [$type]';
    }
    var title = util.getTitle(event);
    var repoName = event.repo.name;
    var issueNumber = util.getIssueNumber(event);

    return '- ($date): $action "$title" ([$repoName/$issueNumber]($url))';
  }
}
