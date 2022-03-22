// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:enhanced_enums/members.dart';
import 'package:test/test.dart';

void main() {
  test('Enum with members to String', () {
    expect(LogPriority.warning.toString(), 'Warning(2)');
    expect(LogPriority.error.toString(), 'Error(1)');
    expect(LogPriority.log.toString(), 'Log(-1)');
  });
}
