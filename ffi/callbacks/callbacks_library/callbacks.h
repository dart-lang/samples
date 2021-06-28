#ifndef CALLBACKS_CALLBACKS_LIBRARY_CALLBACKS_H_
#define CALLBACKS_CALLBACKS_LIBRARY_CALLBACKS_H_

#include <stdint.h>

typedef void (*Callback)(int);

void PerformCallback(Callback cb);

#endif
