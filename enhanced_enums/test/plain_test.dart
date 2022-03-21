import 'package:test/test.dart';

import '../example/plain.dart';

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
}
