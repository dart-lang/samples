// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This file shows how you can define an extension to a JSON-like structure
/// so that it can be used almost like a data class.
///
/// This might create a false sense of (type) security, so use with caution.
void main() {
  var json = {
    'id': 100,
    'name': 'Dash',
  };

  print("${json.name}'s ID is ${json.id}."); // Dash's ID is 100.
}

extension _MyJsonHelper on Map<String, Object> {
  int get id => this['id'];

  String get name => this['name'];
}
