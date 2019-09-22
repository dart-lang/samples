# Experiments with Dart FFI

A series of simple examples demonstrating how to call C libraries from Dart.

Please note that the Dart FFI API is in active development and likely to change
before release. This code is designed to work with *Dart version 2.5.0*.

## Instructions

The C make files are (currently) written to work on a Mac/Windows. To compile the
libraries, go to the `c/` folder in each subproject and run:

```shell
make dylib # Mac
```

```shell
make dll # Windows
```

A .dylib file should be created in the parent folder. Navigate to that and run
the dart file.

