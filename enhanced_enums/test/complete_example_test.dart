// Copyright (c) 2022, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:enhanced_enums/complete_example.dart';
import 'package:test/test.dart';

void main() {
  test('Calculate efficiency of Vehicles', () {
    expect(Vehicle.bicycle.carbonFootprint, 0);
    expect(Vehicle.bus.carbonFootprint, 16);
    expect(Vehicle.car.carbonFootprint, 80);
  });

  test('Sort Vehicles by carbon footprint', () {
    final vehicles = Vehicle.values.toList();

    // Sort using compareTo
    vehicles.sort();

    // Expect order from more efficient to less efficient
    expect(vehicles, [Vehicle.bicycle, Vehicle.bus, Vehicle.car]);
  });

  test('Calculate cost to replace tires', () {
    expect(Vehicle.bicycle.costToReplaceTires(pricePerTire: 10), 70);
    expect(Vehicle.car.costToReplaceTires(pricePerTire: 60), 290);
    expect(Vehicle.bus.costToReplaceTires(pricePerTire: 100), 650);
  });

  test('Travel in a car', () {
    expect(Vehicle.car.travel(), 'I am traveling in a car!');
  });
}
