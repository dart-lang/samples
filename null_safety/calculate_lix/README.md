# Null safety example: A CLI app for calculating lix

This is a small code example of an app that calculates the 'lix' readability
index for a text file. The implementation uses the Dart null safety feature,
and is meant to demonstrate how this feature works in a practical example,
as well as serve as a demonstration of how to configure and run code with null
safety at its current tech preview stage.

## Running the example code

The code works only with preview builds of null safety from the `beta`
channel. If you're using Flutter, you can run:

```cmd
flutter channel stable
flutter upgrade
```

to switch to this channel; alternatively, you may [download and install the Dart
SDK archive](https://dart.dev/tools/sdk/archive#beta-channel) version 2.12 or
above.

### Running from the terminal / command prompt

To run the main app, type these commands in the terminal/command-prompt:

```cmd
$ cd <folder with samples repo>/null_safety/calculate_lix/
$ dart pub get
$ dart run bin/main.dart text/lorem-ipsum.txt
```

### Running from VSCode

This example contains a launch configuration for VSCode that runs
`bin/main.dart`, so to run the sample in
VSCode:

  1. If you're using a separate copy of Dart, rather than the Flutter `dev`
     channel, edit your VSCode configuration to point to one additional Dart
     SDK, the preview SDK we just downloaded. See [details
     here](https://dartcode.org/docs/quickly-switching-between-sdk-versions/)
     for what values to put in **View > Command Palette > Open Settings
     (JSON)**.

  1. Invoke **File > Open**, and select the `calculate_lix` folder.

  1. Tell VSCode to use the preview Dart SDK: Open `bin/main.dart` and then
     locate the 'Dart: \<version number\>' selector in the status bar at the
     bottom, and select `Dart: 2.12.0` (or greater.)

  1. Select **Run > Run** and the project should run and print a message in the
     Debug Console.


### Running from Android Studio

  1. Start Android Studio.

  1. Select Open Project, and select the `calculate_lix` folder.

  1. Open the file `bin/main.dart` in the code editor.

  1. Select 'Open Dart Settings' in the top banner.

  1. Select both 'Enable Dart support' checkmarks at the top and bottom of the
     dialog.
  
  1. Under Dart SDK specify the path to the Dart preview SDK (`2.12.0`, or the
     latest version available). Click OK.

  1. Select Run > Run and the project should run and print a message in the Run
     pane.

## Next steps

Once you have the code running, here some suggestions for things to try:

* In `lib/lix.dart` line 30, try to remove the `required` keyword from one or
  more fields in the constructor, and notice the error shown.

* In `lib/lix.dart` line 49, try to delete the code that initializes one or more
  fields (e.g. `words: words`) and notice the error shown.

* In `lib/lix.dart` line 9, try to make `words` a nullable variable (`int?
  words`), and notice how we don't get errors about not checking for null in
  the `_calculate()` method.

* In `lib/lix.dart` line 22, try to remove the `late` keyword from
  `readability`, and notice how we get an error in the constructor.
