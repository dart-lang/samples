import 'package:enhanced_enums/members.dart';
import 'package:test/test.dart';

void main() {
  test('Enum with members to String', () {
    expect(LogPriority.warning.toString(), 'Warning(2)');
    expect(LogPriority.error.toString(), 'Error(1)');
    expect(LogPriority.log.toString(), 'Log(-1)');
  });
}
