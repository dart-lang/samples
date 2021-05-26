// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <stdio.h>
#include "opaque.h"

int main() {
  printf("main called\n");
  return 0;
}

// Note:
// ---only on Windows---
// Every function needs to be exported to be able to access the functions by dart.
// Refer: https://stackoverflow.com/q/225432/8608146

Opaque ncurses_initscr() {
  return (Opaque)initscr();
}

void ncurses_cbreak() {
  cbreak();
}

void ncurses_noecho() {
  noecho();
}

void ncurses_wprintw(WINDOW *window, char *s) {
  wprintw(window, s);
}

void ncurses_wclear(WINDOW* window) {
  wclear(window);
}

void ncurses_wrefresh(WINDOW* window) {
  wrefresh(window);
}

int ncurses_wgetch(WINDOW* window) {
  return wgetch(window);
}

void ncurses_wmove(WINDOW* window, int row, int col) {
  wmove(window, row, col);
}

void ncurses_endwin() {
  endwin();
}
