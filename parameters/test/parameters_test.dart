import 'package:parameters/parameters.dart';
import 'package:test/test.dart';

void main() {
  test('named argument after positional argument', () {
    final list = [0, 2, 42, 91];

    // `items` named argument appears after the positional argument `predicate`
    final total = countWhere<int>((item) {
      return item % 2 == 0;
    }, items: list);

    expect(total, 3);
  });

  test('named argument before positional argument', () {
    final list = [0, 2, 42, 91];

    // `items` named argument appears before the positional argument `predicate`
    final total = countWhere<int>(items: list, (item) {
      return item % 2 == 0;
    });

    expect(total, 3);
  });

  test('positional argument between named arguments', () {
    final list = [0, 2, 42, 91];

    // positional argument `predicate` appears between 
    // named arguments `items` and `skip`
    final total = countWhere<int>(items: list, (item) {
      return item % 2 == 0;
    }, skip: 1);

    expect(total, 2);
  });
}
