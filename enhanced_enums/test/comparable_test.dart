import 'package:test/test.dart';

import '../example/comparable.dart';

void main() {
  test('Sort Quantity enum using compareTo', () {
    // unsorted list
    final list = [Quantity.many, Quantity.zero, Quantity.one];

    // sort using compareTo
    list.sort();

    // list is sorted by amount
    expect(list, [Quantity.zero, Quantity.one, Quantity.many]);
  });
}
