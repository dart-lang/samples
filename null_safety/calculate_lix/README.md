# Null safety example: A CLI-app for calculating lix

This is a small code example of an app that calculates the 'lix' readability
index for a text file. The implementation uses the new Dart null safety feature,
and is meant to demonstrate how this feature works in a practical example,
as well as serve as a demonstration of how to configure and run code with null
safety at its current tech preview stage.

## Running the example code

The code works only with tech preview builds of null safety from the Dart dev
channel. You will need to download a copy of this Dart SDK even if you have a
Flutter or Dart SDK installed already, and you'll want to use this preview SDK
only for experimenting with null safety. Specifically, do not use it for any
kind of production coding.

### Dart preview SDK installation

  1. Download the latest null safety preview build from the dev-channel in the
     SDK archive: https://dart.dev/tools/sdk/archive#dev-channel. The
     instructions below use `2.10.0-56.0.dev`; you get download a more recent
     build.
   
  1. Unzip the SDK to a folder, e.g. `/Users/michael/dev/preview/dart-sdk` or
     `C:\Users\michael\dev\preview\dart-sdk\`

### Running from the terminal/command-prompt

Because null safety is still in tech preview, we need to pass a so-called
'experiment flag' when invoking and Dart command in the terminal, which looks
like this: `--enable-experiment=non-nullable`.

To run the main app, type these commands in the terminal/command-prompt:

  - Windows:
    - `cd <folder with samples repo>\null_safety\calculate_lix\`
    - `C:\Users\michael\dev\preview\dart-sdk\bin\dart pub get`
    - `C:\Users\michael\dev\preview\dart-sdk\bin\dart --enable-experiment=non-nullable run bin\main.dart text\lorem-ipsum.txt`
  - macOS/Linux:
    - `cd <folder with samples repo>/null_safety/calculate_lix/`
    - `/Users/michael/dev/preview/dart-sdk/bin/dart pub get`
    - `/Users/michael/dev/preview/dart-sdk/bin/dart --enable-experiment=non-nullable run bin/main.dart text/lorem-ipsum.txt`

### Running from VSCode

This example contains a launch configuration for VSCode that runs
`bin/main.dart` passing both the experimental flag, so to run the sample in
VSCode:

  1. Edit your VSCode configuration to point to one additional Dart SDK, the
     preview SDK we just downloaded. See [details
     here](https://dartcode.org/docs/quickly-switching-between-sdk-versions/)
     for what values to put in **View > Command Palette > Open Settings (JSON)**.

  1. Invoke **File > Open**, and select the `calculate_lix` folder.

  1. Tell VSCode to use the preview Dart SDK: Open `bin/main.dart` and then
     locate the 'Dart: <version number>' selector in the status bar at the
     bottom, and select `Dart: 2.10.0-56.0.dev`.

  1. Select **Run > Run** and the project should run and print a message in the Debug
     Console.


### Running from Android Studio

  1. Start Android Studio.

  1. Select Open Project, and select the `calculate_lix` folder.

  1. Open the file `bin/main.dart` in the code editor.

  1. Select 'Open Dart Settings' in the top banner.

  1. Select both 'Enable Dart support' checkmarks at the top and bottom of the dialog.
  
  1. Under Dart SDK specify the path to the Dart preview SDK (2.9.0-14.0.dev). Click OK.

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