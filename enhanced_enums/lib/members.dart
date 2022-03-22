// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Enum with members and named constructor.
///
/// Also shows an example of [toString] override.
enum LogPriority {
  warning(2, "Warning"),
  error(1, "Error"),
  log.unknown("Log");

  const LogPriority(this.priority, this.prefix);
  const LogPriority.unknown(String prefix) : this(-1, prefix);

  final int priority;
  final String prefix;

  @override
  String toString() => '$prefix($priority)';
}
