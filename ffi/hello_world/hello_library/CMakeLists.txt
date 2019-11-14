cmake_minimum_required(VERSION 3.9 FATAL_ERROR)
project(hello_library VERSION 1.0.0 DESCRIPTION "Introductory dart:ffi example")
add_library(hello_library SHARED hello.c)
add_executable(hello_test hello.c)

set_target_properties(hello_library PROPERTIES
    PUBLIC_HEADER hello.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "hello"
#[[
The following is required, but not sufficient, to sign the generated helloworld.dylib.
The identity can be found with `security find-identity -v -p codesigning`.
However, macOS still gets upset with:

$ dart hello.dart
Unhandled exception:
Invalid argument(s): Failed to load dynamic library (dlopen(./hello_library/Debug/libhello.dylib, 1): no suitable image found.  Did find:
        ./hello_library/Debug/libhello.dylib: code signature in (./hello_library/Debug/libhello.dylib) not valid for use in process using Library Validation: mapping process and mapped file (non-platform) have different Team IDs)
#0      _open (dart:ffi-patch/ffi_dynamic_library_patch.dart:10:55)
#1      new DynamicLibrary.open (dart:ffi-patch/ffi_dynamic_library_patch.dart:19:12)
#2      main (file:///Users/brettmorgan/Documents/GitHub/dart-samples/ffi/hello_world/hello.dart:18:36)
#3      _startIsolate.<anonymous closure> (dart:isolate-patch/isolate_patch.dart:305:19)
#4      _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:172:12)

    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
]]
)
