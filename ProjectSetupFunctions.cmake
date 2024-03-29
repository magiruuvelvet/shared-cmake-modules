macro(ProjectSetupClangDebuggerTuningC)
    if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
        if ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
            message(STATUS "C: LLVM/clang detected. Enabling LLDB debugger tuning...")
            set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -glldb")
        endif()
    endif()
endmacro()

macro(ProjectSetupClangDebuggerTuningCxx)
    if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
        if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
            message(STATUS "C++: LLVM/clang detected. Enabling LLDB debugger tuning...")
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -glldb")
        endif()
    endif()
endmacro()

macro(ProjectSetupAppendCCxxFlags Target Flags)
    if ("${Target}" STREQUAL "GLOBAL")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${Flags}")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Flags}")
    else()
        target_compile_definitions(${Target} PRIVATE "${Flags}")
    endif()
endmacro()

macro(ProjectSetupRegisterPlatformMacros Target)
    # note: not required for D

    if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
        set(PROJECT_PLATFORM_OS "Linux" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_LINUX")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_POSIX")

    elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "FreeBSD")
        set(PROJECT_PLATFORM_OS "FreeBSD" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_FREEBSD")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_BSD")

    elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "OpenBSD")
        set(PROJECT_PLATFORM_OS "OpenBSD" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_OPENBSD")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_BSD")

    elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "NetBSD")
        set(PROJECT_PLATFORM_OS "NetBSD" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_NETBSD")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_BSD")

    elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "DragonFlyBSD")
        set(PROJECT_PLATFORM_OS "DragonFlyBSD" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_DRAGONFLYBSD")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_BSD")

    elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin")
        set(PROJECT_PLATFORM_OS "Darwin" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_DARWIN")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_BSD_LIKE")
        if (APPLE)
            ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_MACOS")
        endif()

    elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
        set(PROJECT_PLATFORM_OS "Windows" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_WINDOWS")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_WINNT")

    else()
        set(PROJECT_PLATFORM_OS "" CACHE STRING "" FORCE)
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_UNKNOWN")
        ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_UNDETECTED")
    endif()

    ProjectSetupAppendCCxxFlags(${Target} "-DPROJECT_PLATFORM_NAME=\"${PROJECT_PLATFORM_OS}\"")
endmacro()

# Parameter:
#  - Target
#  - Name (without the .in extension)
macro(ProjectConfigureFile Target Name)
    # check for required variables
    if ("${PROJECT_GENERATED_DIR}" STREQUAL "")
        message(FATAL_ERROR "ProjectConfigureFile requires $PROJECT_GENERATED_DIR to be set. Did you forgot to include ProjectSetup?")
    endif()

    # create output path if not inside root
    get_filename_component(ProjectConfigureFileOutputPath ${Name} DIRECTORY)
    file(MAKE_DIRECTORY "${PROJECT_GENERATED_DIR}/${ProjectConfigureFileOutputPath}")

    # configure file wrapper
    configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/${Name}.in"
        "${PROJECT_GENERATED_DIR}/${Name}"
    )

    # add generated file to target sources
    target_sources(${Target} PRIVATE "${PROJECT_GENERATED_DIR}/${Name}")
endmacro()
