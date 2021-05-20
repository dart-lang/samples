#include <stdint.h>

#include "include/dart_api.h"
#include "include/dart_native_api.h"
#include "include/dart_api_dl.h"

typedef void (*callback_fn)(intptr_t) Callback;

DART_EXPORT void PerformCallback(Callback cb) {
    int i = 0;
    for (;;) {
        cb(i++);
        sleep(1);
    }
}
