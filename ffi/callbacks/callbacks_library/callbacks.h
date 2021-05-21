#ifndef CALLBACKS_H
#define CALLBACKS_H

#include <stdint.h>

typedef void (*Callback)(int);

void PerformCallback(Callback cb);

#endif
