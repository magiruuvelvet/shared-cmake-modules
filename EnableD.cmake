# register support for the D programming language in CMake
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/LanguageSupport/D" "${CMAKE_MODULE_PATH}" CACHE PATH "" FORCE)

# wrapper for defining custom version()s
macro(d_define_version TARGET SCOPE VERSION)
    if ("${CMAKE_D_COMPILER_ID}" STREQUAL "LDC")
        target_compile_options(${TARGET} ${SCOPE} "--d-version=${VERSION}")
    else()
        target_compile_options(${TARGET} ${SCOPE} "-version=${VERSION}")
    endif()
endmacro()
