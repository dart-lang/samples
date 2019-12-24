// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:extension_methods/privacy_source.dart';

/// This file shows how privacy works with extension methods. Extensions
/// named without a leading `_` will be accessible from other files and
/// libraries. Others won't.
void main() {
  print('Flutter'.firstChar);

  // Uncommenting the following line results in a static error. The `addTwo`
  // extension is not reachable from here.
  // print(40.addTwo);

  // Same applies for unnamed extensions.
  // print(true.asInteger);
}
