// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;
import 'dart:io' show Directory, Platform;

// FFI signature of the hello_world C function
typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

main() {
  // Open the dynamic library
  String absolutePath = Directory.current.path;
  var path = "${absolutePath}/hello_library/libhello.so";
  if (Platform.isMacOS) path = '${absolutePath}/hello_library/libhello.dylib';
  if (Platform.isWindows) path = r'${absolutePath}\hello_library\Debug\hello.dll';
  final dylib = ffi.DynamicLibrary.open(path);
  // Look up the C function 'hello_world'
  final HelloWorld hello = dylib
      .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
      .asFunction();
  // Call the function
  hello();
}
