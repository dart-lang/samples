cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(opaque_library VERSION 1.0.0 LANGUAGES C)
add_library(opaque_library SHARED opaque.c opaque.def)
find_package(Curses REQUIRED)

target_link_libraries(opaque_library ${CURSES_LIBRARY})
set_target_properties(opaque_library PROPERTIES
    PUBLIC_HEADER opaque.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "opaque"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
