// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:extension_methods/some_api.dart';

/// This file shows that extension methods can be used in conjunction
/// with operator overloading.
void main() {
  var team = jean + betty;
  team += kay;
  print(team);

  var otherTeam = betty + marlyn;
  if (team > otherTeam) {
    print('The first team ($team) is larger than the other one ($otherTeam).');
  }
}

extension GroupArithmetic on Group {
  Group operator +(Person person) => Group({...people, person});
  bool operator >(Group other) => people.length > other.people.length;
}

extension PersonArithmetic on Person {
  Group operator +(Person other) => Group({this, other});
}
