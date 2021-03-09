include(SetCppStandard)
include(SetCStandard)

macro(CreateTarget CMakeTargetName Type OutputName Language LanguageVersion)
    message(STATUS "Creating ${Language}${LanguageVersion} target: ${CMakeTargetName}")

    # grep files from current directory
    if (${Language} STREQUAL "C++")
        file(GLOB_RECURSE SourceList
            "${SourceListPrefix}*.cpp"
            "${SourceListPrefix}*.hpp"
        )
    elseif(${Language} STREQUAL "C")
        file(GLOB_RECURSE SourceList
            "${SourceListPrefix}*.c"
            "${SourceListPrefix}*.h"
        )
    elseif(${Language} STREQUAL "D")
        file(GLOB_RECURSE SourceList
            "${SourceListPrefix}*.d"
        )
    else()
        message(FATAL_ERROR "CreateTarget: unsupported language: ${Language}")
    endif()

    # create target
    if (${Type} STREQUAL "EXECUTABLE")
        add_executable(${CMakeTargetName} ${SourceList})
        add_library(${CMakeTargetName}_ginterface INTERFACE)
    elseif(${Type} STREQUAL "SHARED")
        add_library(${CMakeTargetName} SHARED ${SourceList})
        add_library(${CMakeTargetName}_ginterface INTERFACE)
        add_library(libs::${CMakeTargetName} ALIAS ${CMakeTargetName}_ginterface)
    elseif(${Type} STREQUAL "STATIC")
        add_library(${CMakeTargetName} STATIC ${SourceList})
        add_library(${CMakeTargetName}_ginterface INTERFACE)
        add_library(libs::${CMakeTargetName} ALIAS ${CMakeTargetName}_ginterface)
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
        set_target_properties(${CMakeTargetName} PROPERTIES LINKER_LANGUAGE D)
    endif()

    # add current directory to include paths of the target
    target_include_directories(${CMakeTargetName} PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/${SourceListPrefix}")
    target_include_directories(${CMakeTargetName}_ginterface INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/${SourceListPrefix}")

    # link target to interface
    if (NOT ${Type} STREQUAL "EXECUTABLE")
        target_link_libraries(${CMakeTargetName}_ginterface INTERFACE ${CMakeTargetName})
    endif()

    # export variable with the current target source directory
    set(CURRENT_TARGET_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
endmacro()

macro(CreateTargetFromPath CMakeTargetName Path Type OutputName Language LanguageVersion)
    set(SourceListPrefix "${Path}/")
    CreateTarget(${CMakeTargetName} ${Type} ${OutputName} ${Language} ${LanguageVersion})
    set(SourceListPrefix "")
endmacro()
