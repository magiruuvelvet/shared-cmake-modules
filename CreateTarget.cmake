include(SetCppStandard)
include(SetCStandard)

macro(CreateTarget CMakeTargetName Type OutputName Language LanguageVersion)
    # grep files from current directory
    if (${Language} STREQUAL "C++")
        file(GLOB_RECURSE SourceList
            "*.cpp"
            "*.hpp"
        )
    elseif(${Language} STREQUAL "C")
        file(GLOB_RECURSE SourceList
            "*.c"
            "*.h"
        )
    elseif(${Language} STREQUAL "D")
        file(GLOB_RECURSE SourceList
            "*.d"
        )
    else()
        message(FATAL_ERROR "CreateTarget: unsupported language: ${Language}")
    endif()

    # create target
    if (${Type} STREQUAL "EXECUTABLE")
        add_executable(${CMakeTargetName} ${SourceList})
    elseif(${Type} STREQUAL "SHARED")
        add_library(${CMakeTargetName} SHARED ${SourceList})
    elseif(${Type} STREQUAL "STATIC")
        add_library(${CMakeTargetName} STATIC ${SourceList})
    else()
        message(FATAL_ERROR "CreateTarget: unsupported type: ${Type}")
    endif()

    # set output name
    set_target_properties(${CMakeTargetName} PROPERTIES PREFIX "")
    set_target_properties(${CMakeTargetName} PROPERTIES OUTPUT_NAME "${OutputName}")

    if (${Language} STREQUAL "C++")
        # sets the required C++ version on the target
        SetCppStandard(${CMakeTargetName} ${LanguageVersion})
        set_target_properties(${CMakeTargetName} PROPERTIES LINKER_LANGUAGE CXX)
    elseif(${Language} STREQUAL "C")
        # sets the required C version on the target
        SetCStandard(${CMakeTargetName} ${LanguageVersion})
        set_target_properties(${CMakeTargetName} PROPERTIES LINKER_LANGUAGE C)
    elseif(${Language} STREQUAL "D")
        # register support for the D programming language in CMake
        set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/LanguageSupport/D" "${CMAKE_MODULE_PATH}")
        set_target_properties(${CMakeTargetName} PROPERTIES LINKER_LANGUAGE D)
    endif()

    # add current directory to include paths of the target
    target_include_directories(${CMakeTargetName} PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")

    # export variable with the current target source directory
    set(CURRENT_TARGET_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endmacro()
