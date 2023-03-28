// Copyright (c) 2023, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A constraint has a list of variables it constrains and
/// a method that checks whether it is satisfied.
abstract class Constraint<V, D> {
  final List<V> variables;

  Constraint(this.variables);

  bool isSatisfied(Map<V, D> assignment);
}

/// An instance of a constraint satisfaction problem.
///
/// A CSP framework is modeled as a set of _variables_ that can be assigned
/// within a range called a _domain_.
///
///  ```dart
/// var doug = Guest('Doug', dislikes: ['artichoke']);
/// var patrick = Guest('Patrick', dislikes: ['bananas']);
/// var susan = Guest('Susan', dislikes: ['broccoli']);
/// var variables = [doug, patrick, susan];
///
/// var meals = ['artichoke', 'bananas', 'broccoli'];
///
/// var domains = {
///   doug: meals,
///   patrick: meals,
///   susan: meals,
/// };
///
/// var csp = CSP<Guest, String>(variables, domains);
///
/// csp.addConstraint(AvoidDislikes(variables));
///
/// var result = csp.backtrackingSearch();
/// print(result);
/// ```
///
class CSP<V, D> {
  final List<V> variables;
  final Map<V, List<D>> domains;
  final Map<V, List<Constraint<V, D>>> constraints = {};

  /// Creates an instance of a constraint satisfaction problem.
  ///
  /// Each variable in the [variables] list must be a key in the [domains] map.
  CSP(this.variables, this.domains) {
    for (var variable in variables) {
      // Add an entry for each variable to the constraints map
      constraints[variable] = [];

      // Check that each variable is present in the domains map
      if (!domains.containsKey(variable)) {
        throw ArgumentError(
            'Each variable should have a domain associated with it.');
      }
    }
  }

  /// Adds a constraint to be used when finding a solution.
  void addConstraint(Constraint<V, D> constraint) {
    for (var variable in constraint.variables) {
      // Check that this constraint's variable is present in this CSP
      if (!variables.contains(variable)) {
        throw ArgumentError(
            "The constraint's variable is not present in this CSP");
      }

      // Add the constraint to the `constraints` map. As long as the previous
      // check succeeded, an entry will exist, so it's safe to cast it to a
      // non-nullable type.
      constraints[variable]!.add(constraint);
    }
  }

  /// Checks whether the value assignment is consistent by checking it against
  /// all constraints for the given variable.
  bool isConsistent(V variable, Map<V, D> assignment) {
    for (var constraint in constraints[variable]!) {
      if (!constraint.isSatisfied(assignment)) {
        return false;
      }
    }

    return true;
  }

  /// Runs a recursive backtracking search for a solution that satisfies all of
  /// the constraints. The constraints are satisfied when isConsistent returns
  /// true.
  ///
  /// This algorithm is similar to a depth-first search and has a time
  /// complexity of O(V) where V is the number of possible assignments.
  Map<V, D>? backtrackingSearch([Map<V, D> assignment = const {}]) {
    // If every variable is assigned, the search is complete.
    if (assignment.length == variables.length) {
      return assignment;
    }
    // Get the first variable in the CSP but not in the assignment.
    V unassigned = variables.firstWhere((v) => !assignment.containsKey(v));

    // Look through every domain value of the first unassigned variable
    for (var value in domains[unassigned]!) {
      // Create a shallow copy of assignment to modify
      final localAssignment = Map<V, D>.from(assignment);
      localAssignment[unassigned] = value;

      if (isConsistent(unassigned, localAssignment)) {
        final result = backtrackingSearch(localAssignment);
        if (result != null) {
          return result;
        }
      }
    }
    return null;
  }
}
