// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

struct Coordinate
{
    double latitude;
    double longitude;
};

struct Place
{
    char *name;
    struct Coordinate *coordinate;
};

struct Coordinate *create_coordinate(double latitude, double longitude);
struct Place *create_place(char *name, double latitude, double longitude);

char *hello_world();
char *reverse(char *str, int length);