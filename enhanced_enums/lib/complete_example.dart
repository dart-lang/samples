// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Complete example that showcases the different use cases for dart enums
/// in a real scenario.
///
/// Enum that represents different types of vehicles.
enum Vehicle with FlatTireMixin, Traveler implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  /// Number of tires of this Vehicle, part of [FlatTireMixin].
  @override
  final int tires;

  /// Number of passengers the Vehicle can transport.
  final int passengers;

  /// Carbon in grams per kilometer.
  final int carbonPerKilometer;

  /// Method that calculates the Carbon Footprint of a Vehicle per passenger.
  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  /// Comparable uses [carbonFootprint] to compare Vehicles.
  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}

/// Mixin that adds extra functionality.
///
/// This Mixin introduces the [tires] member and a method [costToReplaceTires]
/// to calculate the cost of replacing the tires.
mixin FlatTireMixin {
  /// Fixed fee to add to the total cost.
  static const fee = 50;

  /// Number of tires getter, to be implemented by Enum.
  int get tires;

  /// Calculates the price to replace all tires.
  int costToReplaceTires({required int pricePerTire}) {
    return tires * pricePerTire + fee;
  }
}

/// Mixin that adds Enum specific functionality
///
/// This mixin adds the [travel] method, that returns a String
/// with the Enum name in it.
///
/// This mixin can access the property [name] from the Enum.
mixin Traveler on Enum {
  String travel() {
    return 'I am traveling in a $name!';
  }
}
