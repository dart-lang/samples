import 'dart:io';

import 'package:test/test.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  group('structs', () {
    test('make dylib + execute', () async {
      // run 'cmake .'
      var cmake = await Process.run('cmake', ['.'],
          workingDirectory: 'structs_library');
      expect(cmake.exitCode, 0);

      // run 'make'
      var make =
          await Process.run('make', [], workingDirectory: 'structs_library');
      expect(make.exitCode, 0);

      // Verify dynamic library was created
      var file = File('./structs_library/libstructs.so');
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
