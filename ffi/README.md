# Dart FFI Samples

A series of simple examples demonstrating how to call C libraries from Dart.

This code is designed to work with *Dart version 2.6.0* and above.

To learn more about FFI, start with the [C interop using
dart:ffi](https://dart.dev/guides/libraries/c-interop) guide on dart.dev.

## Building native libraries

Each sample uses [CMake][cmake] to generate a Makefile. To build the native
library for each sample:

```bash
cd hello_world/hello_library
cmake .
make
```

The `make` command creates a `libhello.dylib` (macOS), `libhello.dll`
(Windows) or `libhello.so` (Linux) library file.

## Running

Once the native library is built, run `dart <filename>.dart`.

## Using Docker

Samples with a Dockerfile can be tested using Docker:

```
docker build -t dart-ffi .
docker run dart-ffi
```

## macOS code signing
The Dart binary can only load shared libraries that are *signed*. For more
information, see [dart-lang/sdk/issues/38314][signing-issue] for details.

[cmake]: https://cmake.org/
[signing-issue]: https://github.com/dart-lang/sdk/issues/38314
