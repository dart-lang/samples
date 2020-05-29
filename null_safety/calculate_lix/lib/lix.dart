// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class LixCounts {
  // Based on:
  // https://readabilityformulas.com/the-LIX-readability-formula.php.
  int words; // Number of words in general.

  int longWords; // Number of words with more than 6 characters.

  int periods; // Number of periods.

  // TIP: `readability` isn't passed to the constructor, but calculated. By
  // adding the late keyword we tell the analyzer that we've handled
  // initializing it.
  late int readability; // The lix readability index calculated.

  // TIP: Because the fields are all non-nullable, the constructor must
  // initialize them all. We can either set a default value, or like here make
  // the fields 'required', meaning that a value must be passed to the
  // constructor. 'required' is a new keyword introduced as part of null safety
  // which replaces the previous '@required' annotatation.
  LixCounts({
    required this.words,
    required this.longWords,
    required this.periods,
  }) {
    readability = this._calculate();
  }

  // TIP: Notice how we declare a non-nullable uninitalized `result` variable,
  // yet we can return is as a non-nullable result without getting an error.
  //
  // This is possible due to "definete assignement": The Dart analyzer
  // determines that a value has definetely been assigned before we return. Try
  // removing the assignment to `result` in our of the if/else code branches,
  // and notice how an error then appears in the return statement.
  int _calculate() {
    int result;

    if (words == 0 || periods == 0) {
      result = -1;
    } else {
      final sentenceLength = words / periods;
      final wordLength = (longWords * 100) / words;
      result = (sentenceLength + wordLength).round();
    }

    return result;
  }

  // TIP: Notice how flow analysis knows we covered the possible cases for `l`
  // (try removing the last else-statement).
  String get describe {
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

LixCounts calculate(String text) {
  // Count periods: . : ; ! ?
  var periods = (RegExp(r"[.:;!?]").allMatches(text).length);

  // Count words.
  //
  // TIP: We're using null safe versions of the core libraries, so it's clear
  // from the signature of split() that it returns a non-null result.
  var allWords = text.split(RegExp(r"\W+"));
  var words = allWords.length;
  var longWords = allWords.where((w) => w.length > 6).toList().length;

  return LixCounts(words: words, longWords: longWords, periods: periods);
}
