import 'package:enhanced_enums/plain.dart';
import 'package:test/test.dart';

void main() {
  test('Plain enum names', () {
    expect(Plain.foo.name, 'foo');
    expect(Plain.bar.name, 'bar');
    expect(Plain.baz.name, 'baz');
  });

  test('Plain enum index', () {
    expect(Plain.foo.index, 0);
    expect(Plain.bar.index, 1);
    expect(Plain.baz.index, 2);
  });

  test('Get Plain enum values', () {
    expect(Plain.values, [Plain.foo, Plain.bar, Plain.baz]);
  });

}
