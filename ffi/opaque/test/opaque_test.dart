import 'dart:io';

import 'package:test/test.dart';
import 'package:test_utils/test_utils.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
 group('opaque_world', () {
    test('make dylib + execute', () async {
      // run 'cmake .'
      var cmake =
          await Process.run('cmake', ['.'], workingDirectory: 'opaque_library');
      expect(cmake.exitCode, 0);

      // run 'make'
      var make =
          await Process.run('make', [], workingDirectory: 'opaque_library');
      expect(make.exitCode, 0);

      // Verify dynamic library was created (Linux only)
      var filePath = getLibraryFilePath('opaque_library', 'opaque');
      var file = File(filePath);
      expect(await file.exists(), true, reason: '$filePath does not exist');

      // Run the Dart script
      var dartProcess = await Process.run('dart', ['opaque.dart']);

      // Verify program output
      expect(dartProcess.stderr, isEmpty);
      expect(dartProcess.stdout, equals('main called\n'));
      expect(dartProcess.exitCode, equals(0));
    });
  });
}
