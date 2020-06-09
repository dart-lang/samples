// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show Platform;
import 'dart:ffi';
import 'package:ffi/ffi.dart';

// Example of handling a simple C struct
class Coordinate extends Struct {
  @Double()
  double latitude;

  @Double()
  double longitude;

  factory Coordinate.allocate(double latitude, double longitude) =>
      allocate<Coordinate>().ref
        ..latitude = latitude
        ..longitude = longitude;
}

// Example of a complex struct (contains strings and other structs)
class Place extends Struct {
  Pointer<Utf8> name;

  Pointer<Coordinate> coordinate;

  factory Place.allocate(Pointer<Utf8> name, Pointer<Coordinate> coordinate) =>
      allocate<Place>().ref
        ..name = name
        ..coordinate;
}

// C string pointer return function - char *hello_world();
// There's no need for two typedefs here, as both the
// C and Dart functions have the same signature
typedef hello_world_func = Pointer<Utf8> Function();

// C string parameter pointer function - char *reverse(char *str, int length);
typedef reverse_func = Pointer<Utf8> Function(Pointer<Utf8> str, Int32 length);
typedef Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

// C struct pointer return function - struct Coordinate *create_coordinate(double latitude, double longitude);
typedef create_coordinate_func = Pointer<Coordinate> Function(
    Double latitude, Double longitude);
typedef CreateCoordinate = Pointer<Coordinate> Function(
    double latitude, double longitude);

// C struct pointer return function - struct Place *create_place(char *name, double latitude, double longitude);
typedef create_place_func = Pointer<Place> Function(
    Pointer<Utf8> name, Double latitude, Double longitude);
typedef CreatePlace = Pointer<Place> Function(
    Pointer<Utf8> name, double latitude, double longitude);

main() {
  var path = './structs_library/libstructs.so';
  if (Platform.isMacOS) path = './structs_library/libstructs.dylib';
  if (Platform.isWindows) path = r'structs_library\Debug\structs.dll';
  final dylib = DynamicLibrary.open(path);

  final helloWorldPointer =
      dylib.lookup<NativeFunction<hello_world_func>>('hello_world');
  final helloWorld = helloWorldPointer.asFunction<hello_world_func>();
  final messagePointer = helloWorld();
  final message = Utf8.fromUtf8(messagePointer);
  print('$message');

  final reversePointer = dylib.lookup<NativeFunction<reverse_func>>('reverse');
  final reverse = reversePointer.asFunction<Reverse>();
  final reversedMessage = Utf8.fromUtf8(reverse(Utf8.toUtf8('backwards'), 9));
  print('$reversedMessage');

  final createCoordinatePointer =
      dylib.lookup<NativeFunction<create_coordinate_func>>('create_coordinate');
  final createCoordinate =
      createCoordinatePointer.asFunction<CreateCoordinate>();
  final coordinatePointer = createCoordinate(1.0, 2.0);
  final coordinate = coordinatePointer.ref;
  print('Coordinate: ${coordinate.latitude}, ${coordinate.longitude}');

  final createPlacePointer =
      dylib.lookup<NativeFunction<create_place_func>>('create_place');
  final createPlace = createPlacePointer.asFunction<CreatePlace>();
  final placePointer = createPlace(messagePointer, 3.5, 4.6);
  final place = placePointer.ref;
  final placeName = Utf8.fromUtf8(place.name);
  final placeCoordinate = place.coordinate.ref;
  print(
      'Place is called $placeName at ${placeCoordinate.latitude}, ${placeCoordinate.longitude}');
}
