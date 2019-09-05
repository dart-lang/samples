import 'dart:ffi' as ffi;

// FFI signature of the hello_world C function
typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

main() {
  // Open the dynamic library
  final dylib = ffi.DynamicLibrary.open('hello_world.dylib');
  // Look up the C function 'hello_world'
  final HelloWorld hello = dylib
      .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
      .asFunction();
  // Call the function
  hello();
}
