// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Enum that implements a Comparable using a mixin
enum Ordering with EnumIndexOrdering<Ordering> {
  zero,
  few,
  many;
}

/// Mixin that uses the enum index to create a comparable
mixin EnumIndexOrdering<T extends Enum> on Enum implements Comparable<T> {
  @override
  int compareTo(T other) => index - other.index;
}
