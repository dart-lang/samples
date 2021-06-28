import 'dart:io';

import 'package:test/test.dart';
import 'package:test_utils/test_utils.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  group('callbacks', () {
    test('make dylib + execute', () async {
      // run 'cmake .'
      var cmake =
          await Process.run('cmake', ['.'], workingDirectory: 'callbacks_library');
      expect(cmake.exitCode, 0);

      // run 'make'
      var make =
          await Process.run('make', [], workingDirectory: 'callbacks_library');
      expect(make.exitCode, 0);

      // Verify dynamic library was created (Linux only)
      var filePath = getLibraryFilePath('callbacks_library', 'callbacks');
      var file = File(filePath);
      expect(await file.exists(), true, reason: '$filePath does not exist');

      // Run the Dart script
      var dartProcess = await Process.run('dart', ['callbacks.dart']);

      // Verify program output
      expect(dartProcess.stderr, isEmpty);
      expect(dartProcess.stdout, equals('Callbacks World\n'));
      expect(dartProcess.exitCode, equals(0));
    });
  });
}
