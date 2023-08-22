A general-purpose backtracking constraint satisfaction algorithm.

[![Coverage Status](https://coveralls.io/repos/github/dart-lang/samples/badge.svg?branch=main)](https://coveralls.io/github/dart-lang/samples?branch=main)
[![pub package](https://img.shields.io/pub/v/constraint_solver.svg)](https://pub.dev/packages/constraint_solver)

## Usage

A constraint satisfaction problem (CSP) can be used to model problems where
a solution must be found to satisfy one or more constraints. 
Examples of such a problem include event scheduling, or map coloring.

A CSP framework is a set of _variables_ that can be assigned within a range
called a _domain_. For example, If we are cooking dinner for three guests, we
would define them as variables that can be assigned a meal:

```dart
var doug = Person('Doug', dislikes: ['artichoke']);
var patrick = Person('Patrick', dislikes: ['bananas']);
var susan = Person('Susan', dislikes: ['broccoli']);

var variables = [doug, patrick, susan];
```

And the domains (the meal for each guest) could be modeled as a list strings,
one of which will be assigned to each variable (guest).

```dart
var meals = ['artichoke', 'bananas', 'broccoli'];

var domains = {
  doug: meals,
  patrick: meals,
  susan: meals,
};
```

Finally, a constraint can be defined by subclassing of the `Constraint` class:

```dart
class AvoidDislikes extends Constraint<Person, String> {
  AvoidDislikes(super.variables);

  @override
  bool isSatisfied(Map<Person, String> assignment) {
    // ...
  }
}
```

To run a backtracking search of the solution space, instantiate the `CSP` class
and call the `backtrackingSearch` function:

```dart
var csp = CSP<Person, String>(variables, domains);

csp.addConstraint(AvoidDislikes(variables));

var result = csp.backtrackingSearch();
print(result);
```

For complete examples, see the
[examples/](https://github.com/dart-lang/samples/tree/main/package_constraint_solver/example)
directory.

## References

_Classic Computer Science Problems in Java_ - David Kopec
