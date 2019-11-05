import 'dart:io';

import 'package:test/test.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  group('primitives', () {
    test('make dylib + execute', () async {
      // run 'make clean'
      var clean = await Process.run('make', ['-f', 'LinuxMakefile', 'clean'],
          workingDirectory: 'c');
      expect(clean.exitCode, 0);

      // run 'make so'
      var dynamicLib = await Process.run('make', ['-f', 'LinuxMakefile', 'so'],
          workingDirectory: 'c');
      expect(dynamicLib.exitCode, 0);

      // Verify dynamic library was created
      var file = File('./primitives.so');
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
