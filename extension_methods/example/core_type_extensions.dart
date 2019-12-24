// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This file shows how you can extend even basic types like [String]
/// or [int]. Use with caution.
void main() {
  var warning = 'Extensions are here!';
  warning.scream(); // prints "EXTENSIONS ARE HERE!"

  // Extension methods ¯\_(ツ)_/¯
  5.times(() => print('hello'));

  print(null.stop('!!!')); // prints null!!!
}

extension Silly on String {
  void scream() => print(toUpperCase());
}

extension Sillier on int {
  void times(Function f) {
    for (var i = 0; i < this; i++) {
      f();
    }
  }
}

extension Silliest on Object {
  int nah() => hashCode + 42;
  String stop(String x) => toString() + x;
  Type please() => runtimeType;
  bool notAgain(Object other) => this != other;
}
