// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' show Directory, Platform;
import 'dart:ffi';
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';

// Example of handling a simple C struct
class Coordinate extends Struct {
  @Double()
  external double latitude;

  @Double()
  external double longitude;
}

// Example of a complex struct (contains a string and a nested struct)
class Place extends Struct {
  external Pointer<Utf8> name;

  external Coordinate coordinate;
}

// C function: char *hello_world();
// There's no need for two typedefs here, as both the
// C and Dart functions have the same signature
typedef hello_world = Pointer<Utf8> Function();

// C function: char *reverse(char *str, int length)
typedef reverse_native = Pointer<Utf8> Function(
    Pointer<Utf8> str, Int32 length);
typedef Reverse = Pointer<Utf8> Function(Pointer<Utf8> str, int length);

// C function: struct Coordinate create_coordinate(double latitude, double longitude)
typedef create_coordinate_native = Coordinate Function(
    Double latitude, Double longitude);
typedef CreateCoordinate = Coordinate Function(
    double latitude, double longitude);

// C function: struct Place create_place(char *name, double latitude, double longitude)
typedef create_place_native = Place Function(
    Pointer<Utf8> name, Double latitude, Double longitude);
typedef CreatePlace = Place Function(
    Pointer<Utf8> name, double latitude, double longitude);

main() {
  // Open the dynamic library
  var libraryPath =
      path.join(Directory.current.path, 'structs_library', 'libstructs.so');
  if (Platform.isMacOS)
    libraryPath = path.join(
        Directory.current.path, 'structs_library', 'libstructs.dylib');
  if (Platform.isWindows)
    libraryPath = path.join(
        Directory.current.path, 'structs_library', 'Debug', 'structs.dll');
  final dylib = DynamicLibrary.open(libraryPath);

  final helloWorld =
      dylib.lookupFunction<hello_world, hello_world>('hello_world');
  final message = helloWorld().toDartString();
  print('$message');

  final reverse = dylib.lookupFunction<reverse_native, Reverse>('reverse');
  final backwards = 'backwards';
  final reversedMessage =
      reverse(backwards.toNativeUtf8(), backwards.length).toDartString();
  print('$backwards reversed is $reversedMessage');

  final createCoordinate =
      dylib.lookupFunction<create_coordinate_native, CreateCoordinate>(
          'create_coordinate');
  final coordinate = createCoordinate(3.5, 4.6);
  print(
      'Coordinate is lat ${coordinate.latitude}, long ${coordinate.longitude}');

  final createPlace =
      dylib.lookupFunction<create_place_native, CreatePlace>('create_place');
  final place = createPlace('My Home'.toNativeUtf8(), 42.0, 24.0);
  final name = place.name.toDartString();
  final coord = place.coordinate;
  print(
      'The name of my place is $name at ${coord.latitude}, ${coord.longitude}');
}
