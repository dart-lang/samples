// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:parameters/super_initalizer.dart';
import 'package:test/test.dart';

void main() {
  test('Create multiple instances of class Synth', () {
    // Constructor with optional argument, provided
    final juno = VintageSynth("Juno", polyphony: 6);
    expect(juno.toString(), "Synth Juno. Polyphony: 6, oscilators: 1");

    // Constructor with optional argument, not provided
    final tb303 = VintageSynth("TB-303");
    expect(tb303.toString(), "Synth TB-303. Polyphony: 1, oscilators: 1");

    // Constructor with required argument
    final dx7 = DigitalSynth("DX7", polyphony: 6);
    expect(dx7.toString(), "Synth DX7. Polyphony: 6, oscilators: 1");

    // Constructor with required positional arguments
    final ob6 = MultiOscillatorSynth("OB6", 5, 3);
    expect(ob6.toString(), "Synth OB6. Polyphony: 5, oscilators: 3");

    // Constructor with a single required positional arguments
    final minimoog = FixedOscillatorSynth("MiniMoog");
    expect(minimoog.toString(), "Synth MiniMoog. Polyphony: 1, oscilators: 3");
  });
}
