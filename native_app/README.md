# Native compilation sample

This sample demonstrates a command line application compiled to native code
using dart2native. Fetches stats for a GitHub user and prints them to the
console.

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
