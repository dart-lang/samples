// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:calculate_lix/lix.dart' as lix;

void main(List<String> arguments) {
  // Parse the arguments; we expect a single argument containing the file name.
  if (arguments.length != 1) {
    printUsage();
    exit(64);
  } else {
    // Get the file name.
    //
    // TIP: We're using null safe versions of the core libraries, and we already
    // checked that there is a single argument, so we can safely assume the
    // first argument isn't null.
    final fileName = arguments[0];
    print("Calculating Lix of '$fileName'");

    // Calculate lix.
    try {
      final lc = lix.calculate(File(fileName).readAsStringSync());
      print("Lix is: ${lc.readability}, ${lc.describe} to read ("
          "words: ${lc.words}, long words: ${lc.longWords}, "
          "periods: ${lc.periods}).");
    } catch (Exception) {
      print('Invalid input, could not calculate lix!');
    }
  }
}

void printUsage() {
  print('Usage: calclix <text file>');
}
