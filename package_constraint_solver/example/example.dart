// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:constraint_solver/constraint_solver.dart';

void main() {
  var doug = Guest('Doug', dislikes: ['artichoke']);
  var patrick = Guest('Patrick', dislikes: ['bananas']);
  var susan = Guest('Susan', dislikes: ['broccoli']);
  var variables = [doug, patrick, susan];

  var meals = ['artichoke', 'bananas', 'broccoli'];

  var domains = {
    doug: meals,
    patrick: meals,
    susan: meals,
  };

  var csp = CSP<Guest, String>(variables, domains);

  csp.addConstraint(AvoidDislikes(variables));

  var result = csp.backtrackingSearch();
  print(result);
}

class Guest {
  final String name;
  final List<String> dislikes;

  Guest(
    this.name, {
    this.dislikes = const [],
  });

  @override
  String toString() {
    return name;
  }
}

class AvoidDislikes extends Constraint<Guest, String> {
  AvoidDislikes(super.variables);

  @override
  bool isSatisfied(Map<Guest, String> assignment) {
    Set<String> assignedItems = {};
    for (var entry in assignment.entries) {
      var person = entry.key;
      var item = entry.value;

      if (person.dislikes.contains(item)) {
        return false;
      }
      assignedItems.add(item);
    }

    // Check that no duplicate items were assigned.
    if (assignedItems.length != assignment.length) {
      return false;
    }
    return true;
  }
}
