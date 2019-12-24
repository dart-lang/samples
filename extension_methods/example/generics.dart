// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This file shows how you can specify extensions to generics with type
/// bounds. For example, you can define an extension method for `List<int>`,
/// and it won't apply to `List<String>`.
void main() {
  print([1, 2, 3].sum);

  // Uncommenting the following line results in a static error. The `sum`
  // extension is not defined on lists of strings.
  // print(['a', 'b'].sum);
}

extension on List<int> {
  int get sum => fold(0, (a, b) => a + b);
}
