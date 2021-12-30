#include "callbacks.h"
#include <unistd.h>
#include <stdio.h>

//
// This is defined so the linker doesn't complain about missing main.
// This is odd because a shared library (dylib/.so/etc.) shouldn't need a main.
// The other examples define a main, too.
//
// That said, the CmakeLists.txt causes a callbacks_test executable to be
// generated and runing that does print out "main called" message and exits.
//
int main() {
  printf("main called\n");
  return 1;
}

//
// Our PerformCallback function.
// It just loops forever and once per second calls the Dart callback function with
// an ever increasing number.
//
void PerformCallback(Callback cb) {
  int i = 0;
  for (;;) {
    cb(i++);
    sleep(1);
  }
}
