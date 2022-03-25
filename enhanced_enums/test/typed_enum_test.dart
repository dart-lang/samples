// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:enhanced_enums/typed_enum.dart';
import 'package:test/test.dart';

void main() {
  test('Use typed enum', () {
    expect(EnumWithType.numbers.items, [1, 2, 3]);
    expect(EnumWithType.strings.items, ['A', 'B', 'C']);
  });
}
