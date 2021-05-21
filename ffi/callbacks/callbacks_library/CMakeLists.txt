cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(callbacks_library VERSION 1.0.0 LANGUAGES C)
add_library(callbacks_library SHARED callbacks.c callbacks.def)
add_executable(callbacks_test callbacks.c)

set_target_properties(callbacks_library PROPERTIES
    PUBLIC_HEADER callbacks.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "callbacks"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
