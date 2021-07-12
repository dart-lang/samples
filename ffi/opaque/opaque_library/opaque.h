// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include <ncurses.h>

void opaque();

typedef void *Opaque;

Opaque ncurses_initscr();
void ncurses_cbreak();
void ncurses_noecho();

void ncurses_wclear(WINDOW *window);
void ncurses_wprintw(WINDOW *window, char *s);
void ncurses_wrefresh(WINDOW *window);
int ncurses_wgetch(WINDOW *window);

void ncurses_wmove(WINDOW *window, int row, int col);

void ncurses_endwin();
