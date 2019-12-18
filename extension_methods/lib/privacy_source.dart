// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This file defines three extensions. Only [UsableElsewhere] will be seen
/// from other files. The other two extensions are local to this file.
void main() {
  print(3.addTwo);
  print('Dash'.firstChar);
  print(true.asInteger);
}

extension UsableElsewhere on String {
  String get firstChar => substring(0, 1);
}

extension _UsableOnlyInThisFile on int {
  int get addTwo => this + 2;
}

/// This extension is unnamed, so it will also only be usable in this file.
extension on bool {
  int get asInteger => this == true ? 1 : 0;
}
