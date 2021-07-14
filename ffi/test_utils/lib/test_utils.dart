import 'dart:ffi';
import 'dart:io';

import 'package:path/path.dart' as path;

DynamicLibrary getLibrary(String directory, String filename) =>
    DynamicLibrary.open(getLibraryFilePath(directory, filename));

/// Gets the file path of a library, for the platform running this test
///
/// Linux: {path to dart package}/hello_library/libfoo.so
/// macOS: {path to dart package}/hello_library/libfoo.dylib
/// Windows: {path to dart package}/hello_library/Debug/foo.dll
String getLibraryFilePath(String directory, String filename) {
  var currentDirectory = Directory.current.path;

  // Windows doesn't use
  if (!Platform.isWindows) filename = 'lib$filename';

  // Get the path to the library file
  var libraryPath = path.join(currentDirectory, directory, filename);
  if (Platform.isWindows) {
    libraryPath = path.join(currentDirectory, directory, 'Debug', filename);
  }

  // Add extension
  return path.setExtension(libraryPath, getPlatformExtension());
}

String getPlatformExtension() {
  if (Platform.isLinux) return '.so';
  if (Platform.isMacOS) return '.dylib';
  if (Platform.isWindows) return '.dll';
  throw 'Unsupported platform ${Platform.operatingSystem}';
}
