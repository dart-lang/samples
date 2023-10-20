// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This example shows the use of super-initializer parameters.
///
/// Super-initializer parameters allow to forward constructor parameters
/// to the superclass, avoiding having to write the parameter multiple times
/// in the superclass constructor invocation.
library;

/// This example contains multiple classes representing different types of
/// synthesizers, a musical instrument similar to a piano
/// which can be used to create new sounds.
///
/// All subclasses inherit from the [Synth] class and take advantage of the
/// different super-initializer capabilities.
class Synth {
  /// Model name
  final String model;

  /// Amount of notes that can be played at the same time
  final int polyphony;

  /// Amount of sound generators, default to 1
  final int oscillators;

  /// In the class constructor [model] is a positional parameter,
  /// while [polyphony] and [oscillators] are named parameters.
  Synth(
    this.model, {
    required this.polyphony,
    this.oscillators = 1,
  });

  @override
  String toString() {
    return 'Synth $model. Polyphony: $polyphony, oscillators: $oscillators';
  }
}

/// This class represents an old vintage synthesizer.
///
/// [VintageSynth] can only have 1 oscillator.
/// [polyphony] is optional and is 1 by default.
class VintageSynth extends Synth {
  /// [model] is forwarded to the super constructor.
  /// Named parameter [polyphony] is forwarded, with the default value of 1.
  VintageSynth(super.model, {super.polyphony = 1});
}

/// This class represents a modern digital synthesizer.
///
/// [DigitalSynth] can only have 1 oscillator.
/// Named parameter [polyphony] is required.
class DigitalSynth extends Synth {
  /// [model] is forwarded to the super constructor.
  /// Named parameter [polyphony] is forwarded and it is required.
  DigitalSynth(super.model, {required super.polyphony});

  /// The following constructor declaration would not be possible
  /// because [polyphony] is not a positional argument.
  ///
  /// DigitalSynth(super.model, super.polyphony);
}

/// This class represents a complex multi-oscillator synthesizer.
///
/// [MultiOscillator] requires all three parameters.
class MultiOscillatorSynth extends Synth {
  /// This constructor has three positional parameters instead of one.
  ///
  /// [model] is forwarded to the super constructor.
  /// [polyphony] and [oscillators] positional parameters are then passed to the
  /// named parameters in the super constructor.
  MultiOscillatorSynth(
    super.model,
    int polyphony,
    int oscillators,
  ) : super(
          polyphony: polyphony,
          oscillators: oscillators,
        );
}

/// This class represents a synth with a fixed amount
/// of polyphony and oscillators.
///
/// [FixedOscillatorSynth] only requires the positional parameter [model].
class FixedOscillatorSynth extends Synth {
  /// [model] is forwarded to the super constructor.
  /// [polyphony] and [oscillators] are hardcoded.
  FixedOscillatorSynth(super.model)
      : super(
          polyphony: 1,
          oscillators: 3,
        );
}
