import 'dart:io';

import 'package:test/test.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  group('primitives', () {
    test('make dylib + execute', () async {
      // run 'cmake .'
      var cmake = await Process.run('cmake', ['.'],
          workingDirectory: 'primitives_library');
      expect(cmake.exitCode, 0);

      // run 'make'
      var make =
          await Process.run('make', [], workingDirectory: 'primitives_library');
      expect(make.exitCode, 0);

      // Verify dynamic library was created
      var file = File('./primitives_library/libprimitives.so');
      expect(await file.exists(), true);

      // Run the Dart script
      var dartProcess = await Process.run('dart', ['primitives.dart']);
      expect(dartProcess.exitCode, equals(0));

      // Verify program output
      expect(dartProcess.stderr, isEmpty);
      expect(
          dartProcess.stdout,
          equals('3 + 5 = 8\n'
              '3 - 5 = -2\n'
              '3 * 5 = 15\n'
              '3 + 7 + 11 = 21\n'));
    });
  });
}
