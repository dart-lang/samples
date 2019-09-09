// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include "hello.h"

int main()
{
    hello_world();
    return 0;
}

void hello_world()
{
    printf("Hello World\n");
}