# Opaque example

This sample demonstrates use of Opaque types between C and Dart.

While ffi has good support for dealing with common Struct/struct between code in the two languages, sometimes Dart code
will call C code that returns an Opaque handle.  Even in C, programs don't generally examine these Opaque kinds of
things.  Examples might be HWND in Windows programming, a MongoDB connection, a MySQL connection, and so on.  Basically
handles to a "thing" where the handle struct is only really used by the underlying library, not the Dart or C code
proper.

For this example, we choose to implement a subset of ncurses (https://invisible-island.net/ncurses/announce.html) so
these methods can be called from Dart.

The gist of ncurses programming is that you call initscr(), then call various methods to clear the screen, move the
cursor, render colors and attributes and so on.  The updates to the screen do not happen until you call refresh() or
w=rewrefresh() - this is from the olden days where sending characters over a slow modem to update the screen was slow.

We implemnnted a dynamic (or shared) library in C that exposes a handful of the ncurses methods to Dart.  Enough methods
to clear the screen, print strings, read characters in raw mode (no echo, no buffering).  

The initscr() method returns a WINDOW* in C, which we treat as an Opaque type in Dart.  The WINDOW* is returned from our
ncurses_initscr() function.  Since the Dart code has no reason to care about the elements in the WINDOW* struct
returned, we just declare it as type Window (extends Opaque).

The test program exercises the few functions we exposse and reads keys in a loop until you hit the 'q' key.

It should be noted that libncurses.so exists on Linux when ncurses is installed.  In theory, you can open that DynamicLibrary directly and call
every method in ncurses that way.  However, using our own library allows us to conditionally compile for various
operating systems, using the preprecessor ifdef/endif directives.

