// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:extension_methods/some_api.dart';

/// This file shows how extension methods allow you to move from helper
/// functions to helper methods, for a more fluid API.
void main() {
  var team = getTeam();

  // Instead of something like removeYoungest(team) and then print(team),
  // we can do the following thanks to the extension below.
  team
    ..removeYoungest()
    ..show();
}

extension on Group {
  void removeYoungest() {
    var sorted = people.toList()
      ..sort((a, b) => a.dayOfBirth.compareTo(b.dayOfBirth));
    var youngest = sorted.last;
    people.remove(youngest);
  }

  void show() => print(this);
}
