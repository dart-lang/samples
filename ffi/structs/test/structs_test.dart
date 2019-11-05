import 'dart:io';

import 'package:test/test.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  group('structs', () {
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
      var file = File('./structs.so');
      expect(await file.exists(), true);

      // Run the Dart script
      var dartProcess = await Process.run('dart', ['structs.dart']);
      expect(dartProcess.exitCode, equals(0));

      // Verify program output
      expect(dartProcess.stderr, isEmpty);
      expect(
          dartProcess.stdout,
          equals('Hello World\n'
              'sdrawkcab\n'
              'Coordinate: 1.0, 2.0\n'
              'Place is called Hello World at 3.5, 4.6\n'));
    });
  });
}
