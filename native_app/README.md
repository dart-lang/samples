# Native compilation sample

This sample is a command line application that can be compiled to native code
using the [`dart2native`][dart2native] command included in Dart 2.6. The
application fetches stats for a GitHub user and prints them to the console.

This sample also shows how to parse command line options into Dart objects using
[`package:build_cli_annotations`][build-cli] and [`package:build`][build].

## Building and running an executable
To create a standalone executable, run the `dart2native` command on a Dart file
with a `main()` function. By default, it places the executable in the same
directory. The `--output` or `-o` flag is used to change the location of the
executable.

### Linux and macOS
To build the executable:

```bash
dart2native bin/github_activity.dart -o github_activity
```

To run:

```
./github_activity --user jskeet
```

### Windows
To build the executable:

```bash
dart2native bin\github_activity.dart -o github_activity.exe
```

To run:

```
github_activity.exe --user jskeet
```

## Building an AOT snapshot
The `--output-kind` or `-k` flag can be used to create an AOT snapshot:

```bash
dart2native bin/github_activity.dart -k aot -o github_activity.aot
```

This AOT snapshot can be run using the `dartaotruntime` command:

```bash
dartaotruntime github_activity.aot --user jskeet
```

## About this project
Use the `--help` flag for usage instructions:

```
./github_activity --help
```

If you run into rate limiting issues, you can generate a GitHub token and set it
to the `GITHUB_TOKEN` environment variable:

```bash
export GITHUB_TOKEN=<Your token>
```

[dart2native]: https://dart.dev/tools/dart2native
[build]: https://pub.dev/packages/build
[build-cli]: https://pub.dev/packages/build_cli_annotations
[snapshots]: https://github.com/dart-lang/sdk/wiki/Snapshots
