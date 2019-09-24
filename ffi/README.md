# Experiments with Dart FFI

A series of simple examples demonstrating how to call C libraries from Dart.

Please note that the Dart FFI API is in active development and likely to change
before release. This code is designed to work with *Dart version 2.5.0*.

## Instructions

The C make files are (currently) written to work on a Mac. To compile the
libraries, go to the `c/` folder in each subproject and run:

``` shell
make dylib
```

A .dylib file should be created in the parent folder. Navigate to that and run
the dart file.

On Windows:

A dll can be created in two ways.

1. Using `gcc`

    In the subproject's `c/` run

    ```shell
    make dll
    ```

    Install gcc from [msys2](https://www.msys2.org/), a more detailed [tutorial](https://github.com/orlp/dev-on-windows/wiki/Installing-GCC--&-MSYS2).

    And add it to `path` eg: `C:\msys64\mingw64\bin\`.

    And make sure `gcc -dumpmachine` gives something like `x86_64-w64-mingw32` but **NOT** `i686-w64-mingw32`
    eg: `C:\msys64\mingw64\bin\gcc.exe`


2. Using `cl` from the Visual Studio build.
    Follow the [docs](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=vs-2019) to be able to run `nmake.exe` from cmd line.

    * Visual Studio needs to be installed with c/c++ checked.
    * Then add `\path\to\VC\Auxiliary\Build` to `PATH` eg: `C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build` 
    * You can now run `vcvars32.bat` , `vcvars64.bat` , `vcvarsx86_amd64.bat` etc.from the command line as mentioned in the [docs](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=vs-2019#developer_command_file_locations).
    * Then choose your setup and run `vcvars*.bat` and now, `cl.exe` , `nmake.exe` can be used from the command line.

    In the subproject's `c/` run

    ``` shell
    nmake -f Nmakefile dll
    ```

    A .dll file should be created in the parent folder. Navigate to that and run
    the dart file.

    **Only applicable if on Windows:**

    The c/c++ functions should be exported or dart will not be able to lookup the function definitions.

    This can be done in two ways.

    * Using the keyword `__declspec(dllexport)` in the class/function's definition [docs](https://docs.microsoft.com/en-us/cpp/build/exporting-from-a-dll-using-declspec-dllexport?redirectedfrom=MSDN&view=vs-2019)

    * Creating a `.def` file [docs](https://msdn.microsoft.com/en-us/library/d91k01sh.aspx)

    In every subproject's `c/` directory there is `.def` file.

    That might be neccessary (depending on whether the functions were already exported) to create a dynamic link library `dll` on Windows. As it's used to define what functions are to be exported when creating a dll.

    More details on how to write/generate one [here](https://stackoverflow.com/a/32284832/8608146)

