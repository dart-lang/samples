import 'dart:ffi';
import 'dart:io' show Platform, Directory;
import 'package:path/path.dart' as path;

// simple callback function, prints the number passed from C
void my_callback(int n) {
  print('called back $n');
}

// the main program
main() {
  // Open the dynamic library
  var libraryPath =
      path.join(Directory.current.path, 'callbacks_library', 'libcallbacks.so');

  if (Platform.isMacOS) {
    libraryPath = path.join(
        Directory.current.path, 'callbacks_library', 'libcallbacks.dylib');
  }

  if (Platform.isWindows) {
    libraryPath = path.join(
        Directory.current.path, 'callbacks_library', 'Debug', 'callbacks.dll');
  }

  final dl = DynamicLibrary.open(libraryPath);

  // find our PerformCallback function defined in the dynamic library
  final performCallback = dl.lookupFunction<
          Void Function(
              Pointer<NativeFunction<Void Function(IntPtr)>> functionPointer),
          void Function(
              Pointer<NativeFunction<Void Function(IntPtr)>> functionPointer)>(
      'PerformCallback');

  // cast our Dart callback into a function pointer suitable to pass to C routine
  final my_callbackFP =
      Pointer.fromFunction<Void Function(IntPtr)>(my_callback);

  // call the C function with our callback
  performCallback(my_callbackFP);
}
