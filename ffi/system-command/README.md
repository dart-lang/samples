FFI sample demonstrating invoking operating system commands:

  * `macos.dart`: Invoke the `system()` command in `libSystem.dylib`
  * `linux.dart`: Invoke the `system()` command in `libc.so.6`
  * `windows.dart`: Invoke the `ShellExecute` command in `shell32.dll`

To run these samples:
  * Run `pub get` to get the dependencies
  * Run `dart macos.dart`, `dart linux.dart`, or `dart windows.dart`
    depending on the OS you are on.

When run, you should see the system-default browser launch and load the
Dart website, https://dart.dev

## Learn more

To learn more about FFI, start with the [C interop using
dart:ffi](https://dart.dev/guides/libraries/c-interop) guide on dart.dev.

