import 'package:enhanced_enums/comparable_mixin.dart';
import 'package:test/test.dart';


void main() {
  test('Sort enum using compareTo in mixin', () {
    // unsorted list
    final list = [Ordering.many, Ordering.zero, Ordering.few];

    // sort using compareTo
    list.sort();

    // list is sorted by amount
    expect(list, [Ordering.zero, Ordering.few, Ordering.many]);
  });
}
