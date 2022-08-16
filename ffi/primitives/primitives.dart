// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

// C sum function - int sum(int a, int b);
//
// Example of how to pass parameters into C and use the returned result
typedef SumFunc = Int32 Function(Int32 a, Int32 b);
typedef Sum = int Function(int a, int b);

// C subtract function - int subtract(int *a, int b);
//
// Example of how to create pointers in Dart, alloc them, and pass them as
// parameters
typedef SubtractFunc = Int32 Function(Pointer<Int32> a, Int32 b);
typedef Subtract = int Function(Pointer<Int32> a, int b);

// C multiply function - int *multiply(int a, int b);
//
// Example of how to receive pointers in Dart and access the data
typedef MultiplyFunc = Pointer<Int32> Function(Int32 a, Int32 b);
typedef Multiply = Pointer<Int32> Function(int a, int b);

// C free function - void free_pointer(int *int_pointer);
//
// Example of how to free pointers that were allocated in C.
typedef FreePointerFunc = Void Function(Pointer<Int32> a);
typedef FreePointer = void Function(Pointer<Int32> a);

void main() {
  // Open the dynamic library
  var libraryPath = path.join(
      Directory.current.path, 'primitives_library', 'libprimitives.so');
  if (Platform.isMacOS) {
    libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'libprimitives.dylib');
  }
  if (Platform.isWindows) {
    libraryPath = path.join(
        Directory.current.path, 'primitives_library', 'Debug', 'primtives.dll');
  }

  final dylib = DynamicLibrary.open(libraryPath);

  // calls int sum(int a, int b);
  final sumPointer = dylib.lookup<NativeFunction<SumFunc>>('sum');
  final sum = sumPointer.asFunction<Sum>();
  print('3 + 5 = ${sum(3, 5)}');

  // calls int subtract(int *a, int b);
  // Create a pointer
  final p = calloc<Int32>();
  // Place a value into the address
  p.value = 3;

  final subtractPointer =
      dylib.lookup<NativeFunction<SubtractFunc>>('subtract');
  final subtract = subtractPointer.asFunction<Subtract>();
  print('3 - 5 = ${subtract(p, 5)}');

  // Free up allocated memory.
  calloc.free(p);

  // calls int *multiply(int a, int b);
  final multiplyPointer =
      dylib.lookup<NativeFunction<MultiplyFunc>>('multiply');
  final multiply = multiplyPointer.asFunction<Multiply>();
  final resultPointer = multiply(3, 5);
  // Fetch the result at the address pointed to
  final int result = resultPointer.value;
  print('3 * 5 = $result');

  // Free up allocated memory. This time in C, because it was allocated in C.
  final freePointerPointer =
      dylib.lookup<NativeFunction<FreePointerFunc>>('free_pointer');
  final freePointer = freePointerPointer.asFunction<FreePointer>();
  freePointer(resultPointer);
}
