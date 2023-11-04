# Native compilation sample

This sample is a command line application that can be compiled to native code
using the [`dart compile exe`][exe] command.

## Building and running an executable

To create a standalone executable, run the `dart compile exe` command on
a Dart file with a `main()` function.
By default, it places the executable in the same directory.
The `--output` or `-o` flag is used to change the location of the executable.

### Linux and macOS

To build the executable:

```bash
dart compile exe bin/main.dart -o hello_world
```

To run:

```
./hello_world
```

### Windows

To build the executable:

```bash
dart compile exe bin\main.dart -o hello_world.exe
```

To run:

```
hello_world.exe
```

## Building an AOT snapshot

The `--output-kind` or `-k` flag can be used to create an [AOT snapshot][]:

```bash
dart compile aot-snapshot bin/main.dart -o hello_world.aot
```

This AOT snapshot can be run using the `dartaotruntime` command:

```bash
dartaotruntime hello_world.aot
```

[exe]: https://dart.dev/tools/dart-compile#exe
[AOT snapshot]: https://dart.dev/tools/dart-compile#aot-snapshot
