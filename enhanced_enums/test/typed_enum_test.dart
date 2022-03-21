import 'package:enhanced_enums/typed_enum.dart';
import 'package:test/test.dart';

void main() {
  test('Use typed enum', () {
    expect(EnumWithType.numbers.items, [1, 2, 3]);
    expect(EnumWithType.strings.items, ['A', 'B', 'C']);
  });
}
