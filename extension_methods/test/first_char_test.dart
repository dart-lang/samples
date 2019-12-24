// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:extension_methods/privacy_source.dart';
import 'package:test/test.dart';

void main() {
  test('String.firstChar extension works', () {
    expect('Dash'.firstChar, 'D');
  });
}
