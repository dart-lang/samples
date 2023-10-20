// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This example shows the use of named arguments and parameters.
///
/// See the test under `../test/named_parameters_test.dart` for its use.
library;

/// Function that counts the amount of [items] that match a given [predicate],
/// with the option to skip the first [skip] elements.
///
/// This function has three parameters:
/// - Required positional parameter [predicate]
/// - Required named parameter [items]
/// - Optional named parameter [skip]
int countWhere<T>(
  bool Function(T) predicate, {
  required Iterable<T> items,
  int skip = 0,
}) {
  return items.skip(skip).where(predicate).length;
}
