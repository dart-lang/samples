// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Based on:
/// https://readabilityformulas.com/the-LIX-readability-formula.php.
class Lix {
  /// Number of words in general.
  int words;

  /// Number of words with more than 6 characters.
  int longWords;

  /// Number of periods.
  int periods;

  /// The calculated lix readability index.
  ///
  /// TIP: `readability` isn't passed to the constructor, but calculated. By
  /// adding the late keyword we tell the analyzer that it will be initialized
  /// later in the program.
  late int readability;

  /// TIP: Because the fields are all non-nullable, the constructor must
  /// initialize them all. We can either set a default value, or like here make
  /// the fields 'required', meaning that a value must be passed to the
  /// constructor. 'required' is a new keyword introduced as part of null safety
  /// which replaces the previous '@required' annotation.
  Lix({
    required this.words,
    required this.longWords,
    required this.periods,
  }) {
    readability = _calculate();
  }

  factory Lix.fromString(String text) {
    // Count periods: . : ; ! ?
    var periods = RegExp(r'[.:;!?]').allMatches(text).length;

    // Count words.
    //
    // TIP: We're using null safe versions of the core libraries, so it's clear
    // from the signature of split() that it returns a non-null result.
    var allWords = text.split(RegExp(r'\W+'));
    var words = allWords.length;
    var longWords = allWords.where((w) => w.length > 6).toList().length;

    return Lix(words: words, longWords: longWords, periods: periods);
  }

  /// TIP: Notice how we declare a non-nullable uninitialized `result` variable,
  /// yet we can return is as a non-nullable result without getting an error.
  ///
  /// This is possible due to "definite assignment": The Dart analyzer
  /// determines that a value has definitely been assigned before we return. Try
  /// removing the assignment to `result` in our of the if/else code branches,
  /// and notice how an error then appears in the return statement.
  int _calculate() {
    int result;

    if (words == 0 || periods == 0) {
      throw ArgumentError('Text must contain at least one full sentence.');
    } else {
      final sentenceLength = words / periods;
      final wordLength = (longWords * 100) / words;
      result = (sentenceLength + wordLength).round();
    }

    return result;
  }

  /// TIP: Notice how flow analysis knows that every branch returns a value for
  /// `readability` and so it's ok to have a non-nullable return type (try
  /// removing the last else-statement).
  String describe() {
    if (readability > 0 && readability < 20) {
      return 'very easy';
    } else if (readability < 30) {
      return 'easy';
    } else if (readability < 40) {
      return 'a little hard';
    } else if (readability < 50) {
      return 'hard';
    } else if (readability < 60) {
      return 'very hard';
    } else {
      return 'unknown';
    }
  }
}
