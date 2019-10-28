# Native compilation sample

This sample is a command line application that can be compiled to native code
using the `dart2native` command included in Dart 2.6. The application fetches
stats for a GitHub user and prints them to the console.

This sample also shows how to parse command line options into Dart object using
[`package:build_cli_annotations`][build-cli] and [`package:build`][build].

## Building an executable
To create a standalone executable, Run the `dart2native` command on a Dart file
with a `main()` function. By default, it places the executable in the same
directory. The `--output` or `-o` flag is used to change the location of the
executable.

### Linux and macOS

```bash
dart2native bin/github_activity.dart -o github_activity
```

### Windows

```bash
dart2native bin/github_activity.dart -o github_activity.exe
```

## Building an AOT snapshot
The `--output-kind` or `-k` flag can be used to create an AOT snapshot:

```bash
dart2native bin/github_activity.dart -k aot -o github_activity.aot
```

This AOT snapshot can be run using the `dartaotruntime` command:

```bash
dartaotruntime github_activity.aot --user hixie
```

## About this project
The following command will print events from the past week:

```
./github_activity --user johnpryan --format markdown --interval week
```

If you run into rate limiting issues, you can generate a GitHub token and set it
to the `GH_STATS_TOKEN` environment variable:

```bash
export GH_STATS_TOKEN=<Your token>
```

[build]: https://pub.dev/packages/build
[build-cli]: https://pub.dev/packages/build_cli_annotations
[snapshots]: https://github.com/dart-lang/sdk/wiki/Snapshots
