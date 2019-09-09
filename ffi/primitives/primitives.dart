// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

// C sum function - int sum(int a, int b);
// Example of how to pass paramters into C and use the returned result
typedef sum_func = ffi.Int32 Function(ffi.Int32 a, ffi.Int32 b);
typedef Sum = int Function(int a, int b);

// C subtract function - int subtract(int *a, int b);
// Example of how to create pointers in Dart, alloc them, and pass them as parameters
typedef subtract_func = ffi.Int32 Function(
    ffi.Pointer<ffi.Int32> a, ffi.Int32 b);
typedef Subtract = int Function(ffi.Pointer<ffi.Int32> a, int b);

// C multiply function - int *multiply(int a, int b);
// Example of how to receive pointers in Dart and access the data
typedef multiply_func = ffi.Pointer<ffi.Int32> Function(
    ffi.Int32 a, ffi.Int32 b);
typedef Multiply = ffi.Pointer<ffi.Int32> Function(int a, int b);

// C multi sum fuction - int multi_sum(int nr_count, ...);
// Example of how to call C functions with varargs with a fixed arg count in Dart
typedef multi_sum_func = ffi.Int32 Function(
    ffi.Int32 numCount, ffi.Int32 a, ffi.Int32 b, ffi.Int32 c);
typedef MultiSum = int Function(int numCount, int a, int b, int c);

main() {
  final dylib = ffi.DynamicLibrary.open('primitives.dylib');

  // calls int sum(int a, int b);
  final sumPointer = dylib.lookup<ffi.NativeFunction<sum_func>>('sum');
  final sum = sumPointer.asFunction<Sum>();
  print('3 + 5 = ${sum(3, 5)}');

  // calls int subtract(int *a, int b);
  // Create a pointer
  final p = ffi.Pointer<ffi.Int32>.allocate();
  // Place a value into the address
  p.store(3);
  final subtractPointer =
      dylib.lookup<ffi.NativeFunction<subtract_func>>('subtract');
  final subtract = subtractPointer.asFunction<Subtract>();
  print('3 - 5 = ${subtract(p, 5)}');

  // calls int *multiply(int a, int b);
  final multiplyPointer =
      dylib.lookup<ffi.NativeFunction<multiply_func>>('multiply');
  final multiply = multiplyPointer.asFunction<Multiply>();
  final resultPointer = multiply(3, 5);
  // Fetch the result at the address pointed to
  final int result = resultPointer.load();
  print('3 * 5 = $result');

  // example calling a C function with varargs
  // calls int multi_sum(int nr_count, ...);
  final multiSumPointer =
      dylib.lookup<ffi.NativeFunction<multi_sum_func>>('multi_sum');
  final multiSum = multiSumPointer.asFunction<MultiSum>();
  print('3 + 7 + 11 = ${multiSum(3, 3, 7, 11)}');
}

ffi.Pointer<ffi.Int32> _createCIntArray(List<int> nums) {
  final ptr = ffi.Pointer<ffi.Int32>.allocate(count: nums.length);
  for (var i = 0; i < nums.length; i++) {
    ptr.elementAt(i).store(nums[i]);
  }
  return ptr;
}
