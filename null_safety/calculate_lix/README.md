# Null safety example: A CLI app for calculating lix

This is a small code example of an app that calculates the 'lix' readability
index for a text file. The implementation uses the Dart null safety feature,
and is meant to demonstrate how this feature works in a practical example.

## Supported SDK versions

The example requires Dart 2.12 or later. If you're using Flutter, you need
Flutter 2.0 or later.

### Running from the terminal / command prompt

To run the main app, type these commands in the terminal/command-prompt:

```cmd
$ cd <folder with samples repo>/null_safety/calculate_lix/
$ dart pub get
$ dart run bin/main.dart text/lorem-ipsum.txt
```

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
