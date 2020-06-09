# Command line app sample
This sample demonstrates how to parse command line options into Dart objects
using [`package:build_cli_annotations`][build-cli], read environment variables,
use third-party packages like `package:github` and use core library APIs like
DateTime.

## Adding new CLI options
To add new command line options to `lib/src/options.dart`, update the `Options`
class and re-run `build_runner`:

```bash
pub run build_runner build
```

## About this project
`bin/github_activity.dart` is a command line application that fetches stats for
a GitHub user and prints them to the console.

Use the `--help` flag for usage instructions:

```bash
./github_activity --help
```

If you run into rate limiting issues, you can generate a GitHub token and set it
to the `GITHUB_TOKEN` environment variable:

```bash
export GITHUB_TOKEN=<Your token>
```

[build-cli]: https://pub.dev/packages/build_cli_annotations
