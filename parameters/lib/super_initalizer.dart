// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This example shows the use of super-initializer parameters.
///
/// Super-initializer parameters allow to forward constructor parameters
/// to the superclass, avoiding having to write the parameter multiple times
/// in the superclass contructor invocation.

/// This class represents a synthesizer, a musical instrument similar to a
/// piano which can be used to create new sounds.
///
/// The class [Synth] contains three members:
/// - [model] model name.
/// - [polyphony] amount of notes that can be played simultaneously.
/// - [oscilators] amount of sound generators, default to 1.
///
/// [model] is a positional parameter,
/// while [polyphony] and [oscilators] are named parameters.
class Synth {
  final String model;
  final int polyphony;
  final int oscilators;

  Synth(
    this.model, {
    required this.polyphony,
    this.oscilators = 1,
  });

  @override
  String toString() {
    return 'Synth $model. Polyphony: $polyphony, oscilators: $oscilators';
  }
}

/// This class represents an old vintage synthesizer.
///
/// [VintageSynth] can only have 1 oscilator.
/// [polyphony] is optional and is 1 by default.
class VintageSynth extends Synth {
  /// [model] is forwarded to the super constructor.
  /// Named parameter [polyphony] is forwarded, with the default value of 1.
  VintageSynth(super.model, {super.polyphony = 1});
}

/// This class represents a modern digital synthesizer.
///
/// [DigitalSynth] can only have 1 oscilator.
/// Named parameter [polyphony] is required.
class DigitalSynth extends Synth {
  /// [model] is forwarded to the super constructor.
  /// Named parameter [polyphony] is forwarded and it is required.
  DigitalSynth(super.model, {required super.polyphony});

  /// The following constructor declaration would not be possible
  /// because [polyphony] is not positional.
  ///
  /// DigitalSynth(super.model, super.polyphony);
}

/// This class represents a complex multi-oscilator synthesizer.
///
/// [MultiOscilator] requires all three parameters.
class MultiOscilatorSynth extends Synth {
  /// This constructor has three positional parameters instead of one.
  ///
  /// [model] is forwarded to the super constructor.
  /// [polyphony] and [oscilators] positional parameters are then passed to the
  /// named parameters in the super constructor.
  MultiOscilatorSynth(
    super.model,
    int polyphony,
    int oscilators,
  ) : super(
          polyphony: polyphony,
          oscilators: oscilators,
        );
}

/// This class represents a synth with a fixed amount
/// of polyphony and oscilators.
///
/// [FixedOscilatorSynth] only requires the positional parameter [model].
class FixedOscilatorSynth extends Synth {
  /// [model] is forwarded to the super constructor.
  /// [polyphony] and [oscilators] are hardcoded.
  FixedOscilatorSynth(super.model)
      : super(
          polyphony: 1,
          oscilators: 3,
        );
}
