cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(primitives_library VERSION 1.0.0 LANGUAGES C)
add_library(primitives_library SHARED primitives.c primitives.def)
add_executable(primitives_test primitives.c)

set_target_properties(primitives_library PROPERTIES
    PUBLIC_HEADER primitives.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "primitives"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
