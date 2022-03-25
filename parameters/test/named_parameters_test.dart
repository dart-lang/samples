// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:parameters/named_parameters.dart';
import 'package:test/test.dart';

void main() {
  test('named argument after positional argument', () {
    final list = [0, 2, 42, 91];

    // `items` named argument appears after the positional argument `predicate`
    // Default argument `skip` is not provided
    final total = countWhere<int>((item) {
      return item % 2 == 0;
    }, items: list);

    expect(total, 3);
  });

  test('named argument before positional argument', () {
    final list = [0, 2, 42, 91];

    // `items` named argument appears before the positional argument `predicate`
    // Default argument `skip` is not provided
    final total = countWhere<int>(items: list, (item) {
      return item % 2 == 0;
    });

    expect(total, 3);
  });

  test('positional argument between named arguments', () {
    final list = [0, 2, 42, 91];

    // positional argument `predicate` appears between
    // named arguments `items` and `skip`
    final total = countWhere<int>(
      items: list,
      (item) {
        return item % 2 == 0;
      },
      skip: 1,
    );

    expect(total, 2);
  });
}
