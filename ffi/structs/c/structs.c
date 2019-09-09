// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include <stdlib.h>
#include "structs.h"

int main()
{
    struct Coordinate *coord = create_coordinate(3.5, 4.5);
    printf("Coordinate is lat %.2f, long %.2f\n", coord->latitude, coord->longitude);

    struct Place *place = create_place("My Home", 1.0, 2.0);
    printf("The name of my place is %s at %.2f, %.2f\n", place->name, place->coordinate->latitude, place->coordinate->longitude);

    printf("%s\n", hello_world());
    printf("%s\n", reverse("backwards", 9));
    return 0;
}

struct Coordinate *create_coordinate(double latitude, double longitude)
{
    struct Coordinate *coordinate = (struct Coordinate *)malloc(sizeof(struct Coordinate));
    coordinate->latitude = latitude;
    coordinate->longitude = longitude;
    return coordinate;
}

struct Place *create_place(char *name, double latitude, double longitude)
{
    struct Place *place = (struct Place *)malloc(sizeof(struct Place));
    place->name = name;
    place->coordinate = create_coordinate(latitude, longitude);
    return place;
}

char *hello_world()
{
    return "Hello World";
}

char *reverse(char *str, int length)
{
    char *reversed_str = (char *)malloc((length + 1) * sizeof(char));
    for (int i = 0; i < length; i++)
    {
        reversed_str[length - i - 1] = str[i];
    }
    reversed_str[length] = '\0';
    return reversed_str;
}