import 'dart:io';

import 'package:test/test.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  group('hello_world', () {
    test('execution', () async {
      // Run the Dart script
      var dartProcess = await Process.run('dart', ['hello.dart']);
      expect(dartProcess.exitCode, equals(0));

      // Verify program output
      expect(dartProcess.stderr, isEmpty);
      expect(dartProcess.stdout, equals('Hello World\n'));
    });
  });
}
