// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This is an API that we wrap with extension methods elsewhere. There is
/// no extension method to be seen here.
///
/// Imagine that this code is coming from a different package, so we can't
/// directly change it.
library some_api;

final betty = Person('Betty Holberton', DateTime(1917, 3, 7));

final jean = Person('Jean Bartik', DateTime(1924, 12, 27));

final kay = Person('Kay Antonelli', DateTime(1921, 2, 12));

final marlyn = Person('Marlyn Meltzer', DateTime(1922));

Group getTeam() => Group({jean, betty, kay, marlyn});

class Group {
  final Set<Person> people;

  const Group(this.people);

  @override
  String toString() => people.map((p) => p.name).join(', ');
}

class Person {
  final String name;
  final DateTime dayOfBirth;

  const Person(this.name, this.dayOfBirth);
}
