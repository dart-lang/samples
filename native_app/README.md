# Native compilation sample

This sample is a command line application that can be compiled to native code
using dart2native. The application fetches stats for a GitHub user and prints
them to the console.

This sample also shows how to parse command line options into Dart object using
[`package:build_cli_annotations`][build-cli] and [`package:build`][build].

## Building
Use the `dart2native` command included in Dart 2.6:

### Linux and macOS

```
dart2native bin/github_activity.dart -o github_activity
```

## Windows

```
dart2native bin/github_activity.dart -o github_activity.exe
```

## Using
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
