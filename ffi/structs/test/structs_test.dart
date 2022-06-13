import 'dart:io';

import 'package:test/test.dart';
import 'package:test_utils/test_utils.dart';

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
      var filePath = getLibraryFilePath('structs_library', 'structs');
      var file = File(filePath);
      expect(await file.exists(), true, reason: '$filePath does not exist.');

      // Run the Dart script
      var dartProcess = await Process.run('dart', ['structs.dart']);
      expect(dartProcess.exitCode, equals(0), reason: dartProcess.stderr);

      // Verify program output
      expect(dartProcess.stderr, isEmpty);
      expect(dartProcess.stdout, equals(_expected));
    });
  });
}

const _expected = 'Hello World\n'
    'backwards reversed is sdrawkcab\n'
    'Coordinate is lat 3.5, long 4.6\n'
    'The name of my place is My Home at 42.0, 24.0\n'
    'distance between (2,2) and (5,6) = 5.0\n';
