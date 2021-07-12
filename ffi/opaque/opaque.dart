// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi'; //  as ffi;
import 'dart:io' show Platform, Directory;
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';

class Window extends Opaque {}

// typedefs for the Dart ncurses_* functions and
// FFI signatures of ncurses_* functions in our opaque_library.
typedef native_initscr = Pointer<Window> Function();
typedef dart_initscr = Pointer<Window> Function();

typedef native_endwin = Void Function();
typedef dart_endwin = void Function();

typedef native_wmove = Void Function(Pointer<Window> window, Int64 row, Int64 col);
typedef dart_wmove = void Function(Pointer<Window> window, int row, int col);

typedef native_wclear = Void Function(Pointer<Window> window);
typedef dart_wclear = void Function(Pointer<Window> window);

typedef native_wrefresh = Void Function(Pointer<Window> window);
typedef dart_wrefresh = void Function(Pointer<Window> window);

typedef native_wgetch = Int64 Function(Pointer<Window> window);
typedef dart_wgetch = int Function(Pointer<Window> window);

typedef native_wprintw = Void Function(Pointer<Window> window, Pointer<Utf8> s);
typedef dart_wprintw = void Function(Pointer<Window> window, Pointer<Utf8> s);

typedef native_cbreak = Void Function();
typedef dart_cbreak = void Function();
typedef native_noecho = Void Function();
typedef dart_noecho = void Function();

main() {
  // Open the dynamic library
  var libraryPath =
      path.join(Directory.current.path, 'opaque_library', 'libopaque.so');
  if (Platform.isMacOS)
    libraryPath =
        path.join(Directory.current.path, 'opaque_library', 'libopaque.dylib');
  if (Platform.isWindows)
    libraryPath = path.join(
        Directory.current.path, 'opaque_library', 'Debug', 'opaque.dll');

  final DynamicLibrary dylib = DynamicLibrary.open(libraryPath);

  // Look up the C functions.
  final initscr =
      dylib.lookupFunction<native_initscr, dart_initscr>('ncurses_initscr');
  final endwin =
      dylib.lookupFunction<native_endwin, dart_endwin>('ncurses_endwin');
  final wclear =
      dylib.lookupFunction<native_wclear, dart_wclear>('ncurses_wclear');
  final wmove =
      dylib.lookupFunction<native_wmove, dart_wmove>('ncurses_wmove');
  final wrefresh =
      dylib.lookupFunction<native_wrefresh, dart_wrefresh>('ncurses_wrefresh');
  final wgetch =
      dylib.lookupFunction<native_wgetch, dart_wgetch>('ncurses_wgetch');
  final wprintw =
      dylib.lookupFunction<native_wprintw, dart_wprintw>('ncurses_wprintw');
  final cbreak =
      dylib.lookupFunction<native_cbreak, dart_cbreak>('ncurses_cbreak');
  final noecho =
      dylib.lookupFunction<native_noecho, dart_noecho>('ncurses_noecho');

  final win = initscr();
  noecho();
  cbreak();
  wclear(win);
  wprintw(win, 'hello, world\n'.toNativeUtf8());
  wmove(win, 10, 10);
  wprintw(win, 'at 10,10\n'.toNativeUtf8());
  wmove(win, 20, 20);
  wprintw(win, 'at 20,20 - HIT q TO QUIT\n'.toNativeUtf8());
  wrefresh(win);

  for (;;) {
    final c = String.fromCharCode(wgetch(win));
    if (c == 'q') {
      break;
    }
    wprintw(win, 'char $c\n'.toNativeUtf8());
    wrefresh(win);
  }

  endwin();
}
