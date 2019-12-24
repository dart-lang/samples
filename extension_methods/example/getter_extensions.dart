// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This file shows how you can use extension methods for something akin
/// to type literals.
///
/// In this case, we can write `12.km` instead of `const MetricLength(12000)`.
void main() {
  var a = 50.m;
  var b = 12.km;
  var c = a + b;
  print(c.meters); // 12050
}

class MetricLength {
  final int meters;

  const MetricLength(this.meters);

  MetricLength operator +(MetricLength other) =>
      MetricLength(meters + other.meters);
}

extension MetricLengthGetters on int {
  MetricLength get m => MetricLength(this);
  MetricLength get km => MetricLength(this * 1000);
}
