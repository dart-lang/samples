# Experiments with Dart FFI

A series of simple examples demonstrating how to call C libraries from Dart.

Please note that the Dart FFI API is in active development and likely to change
before release. This code is designed to work with *Dart version 2.5.0*.

## Instructions

Each sample uses [CMake][cmake] to generate a Makefile. To build the native
library for each sample:

```bash
cd hello_world/hello_library
cmake .
make
```

The `make` command creates a `libhello.dylib` (macOS), `libhello.dll`
(Windows) or `libhello.so` (Linux) library file.

## Using Docker

Samples with a Dockerfile can be tested using Docker:

```
docker build -t dart-ffi .
docker run dart-ffi
```

[cmake]: https://cmake.org/