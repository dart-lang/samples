// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Enum with a generic type.
///
/// The type [T] is used to define the type of [List] the enum contains.
enum EnumWithType<T> {
  numbers<int>([1, 2, 3]),
  strings<String>(['A', 'B', 'C']);

  final List<T> items;

  const EnumWithType(this.items);
}
