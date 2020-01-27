cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(structs_library VERSION 1.0.0 LANGUAGES C)
add_library(structs_library SHARED structs.c structs.def)
add_executable(structs_test structs.c)

set_target_properties(structs_library PROPERTIES
    PUBLIC_HEADER structs.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "structs"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)
