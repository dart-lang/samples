// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Enum that implements a Comparable
enum Ordering implements Comparable<Ordering> {
  zero(0),
  one(1),
  many(99);

  final int quantity;

  const Ordering(this.quantity);

  @override
  int compareTo(Ordering other) => quantity - other.quantity;
}
