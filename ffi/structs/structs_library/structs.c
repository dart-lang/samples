// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "structs.h"

int main()
{
    printf("%s\n", hello_world());
    char* backwards = "backwards";
    printf("%s reversed is %s\n", backwards, reverse(backwards, 9));

    struct Coordinate coord = create_coordinate(3.5, 4.6);
    printf("Coordinate is lat %.2f, long %.2f\n", coord.latitude, coord.longitude);

    struct Place place = create_place("My Home", 42.0, 24.0);
    printf("The name of my place is %s at %.2f, %.2f\n", place.name, place.coordinate.latitude, place.coordinate.longitude);

    return 0;
}

char *hello_world()
{
    return "Hello World";
}

char *reverse(char *str, int length)
{
    // Allocates native memory in C.
    char *reversed_str = (char *)malloc((length + 1) * sizeof(char));
    for (int i = 0; i < length; i++)
    {
        reversed_str[length - i - 1] = str[i];
    }
    reversed_str[length] = '\0';
    return reversed_str;
}

void free_string(char *str)
{
    // Free native memory in C which was allocated in C.
    free(str);
}

struct Coordinate create_coordinate(double latitude, double longitude)
{
    struct Coordinate coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    return coordinate;
}

struct Place create_place(char *name, double latitude, double longitude)
{
    struct Place place;
    place.name = name;
    place.coordinate = create_coordinate(latitude, longitude);
    return place;
}

double distance(struct Coordinate c1, struct Coordinate c2) {
    double xd = c2.latitude - c1.latitude;
    double yd = c2.longitude - c1.longitude;
    return sqrt(xd*xd + yd*yd);
}

