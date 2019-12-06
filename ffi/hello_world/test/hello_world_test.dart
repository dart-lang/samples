import 'dart:io';

import 'package:test/test.dart';

// These tests are Linux-only. For platform-specific instructions, see the
// README.
void main() async {
  if (Platform.isMacOS) ;

  if (Platform.isLinux)
    group('hello_world-linux', () {
      test('make dylib + execute', () async {
        // run 'make clean'
        var clean = await Process.run('make', ['-f', 'LinuxMakefile', 'clean'],
            workingDirectory: 'c');
        expect(clean.exitCode, 0);

        // run 'make so'
        var dynamicLib = await Process.run(
            'make', ['-f', 'LinuxMakefile', 'so'],
            workingDirectory: 'c');
        expect(dynamicLib.exitCode, 0);

        // Verify dynamic library was created
        var file = File('./hello_world.so');
        expect(await file.exists(), true);

        // Run the Dart script
        var dartProcess = await Process.run('dart', ['hello.dart']);
        expect(dartProcess.exitCode, equals(0));

        // Verify program output
        expect(dartProcess.stderr, isEmpty);
        expect(dartProcess.stdout, equals('Hello World\n'));
      });
    });

  if (Platform.isWindows)
    group('hello_world-windows', () {
      test('make dll + execute', () async {
        // run 'make clean'
        var clean = await Process.run('nmake.exe', ['-f', 'NmakeFile', 'clean'],
            workingDirectory: 'c');
        expect(clean.exitCode, 0);

        // run 'make so'
        var dynamicLib = await Process.run(
            'nmake.exe', ['-f', 'NmakeFile', 'dll'],
            workingDirectory: 'c');
        expect(dynamicLib.exitCode, 0);

        // Verify dynamic library was created
        var file = File('./hello_world.dll');
        expect(await file.exists(), true);

        // Run the Dart script
        var dartProcess = await Process.run('dart', ['hello.dart']);
        expect(dartProcess.exitCode, equals(0));

        // Verify program output
        expect(dartProcess.stderr, isEmpty);
        expect(dartProcess.stdout, equals('Hello World\n'));
      });
    });
}
