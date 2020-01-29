// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

main() {
  ShellExecute('open', 'https://dart.dev');
}

/*
HINSTANCE ShellExecuteW(
  HWND    hwnd,
  LPCWSTR lpOperation,
  LPCWSTR lpFile,
  LPCWSTR lpParameters,
  LPCWSTR lpDirectory,
  INT     nShowCmd
);

https://docs.microsoft.com/en-us/windows/win32/api/shellapi/nf-shellapi-shellexecutew
*/
typedef ShellExecuteC = ffi.Int32 Function(
    ffi.Pointer hwnd,
    ffi.Pointer lpOperation,
    ffi.Pointer lpFile,
    ffi.Pointer lpParameters,
    ffi.Pointer lpDirectory,
    ffi.Uint32 nShowCmd);
typedef ShellExecuteDart = int Function(
    ffi.Pointer parentWindow,
    ffi.Pointer operation,
    ffi.Pointer file,
    ffi.Pointer parameters,
    ffi.Pointer directory,
    int showCmd);

int ShellExecute(String operation, String file) {
  // Load shell32.
  final dylib = ffi.DynamicLibrary.open('shell32.dll');

  // Look up the `ShellExecuteW` function.
  final ShellExecuteP =
      dylib.lookupFunction<ShellExecuteC, ShellExecuteDart>('ShellExecuteW');

  // Allocate pointers to Utf8 arrays containing the command arguments.
  final operationP = Utf16.toUtf16(operation);
  final fileP = Utf16.toUtf16(file);
  const int SW_SHOWNORMAL = 1;

  // Invoke the command, and free the pointers.
  var result = ShellExecuteP(
      ffi.nullptr, operationP, fileP, ffi.nullptr, ffi.nullptr, SW_SHOWNORMAL);
  free(operationP);
  free(fileP);

  return result;
}
