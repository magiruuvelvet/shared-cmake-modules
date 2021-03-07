##
## General project setup for all my projects.
##

message(STATUS "Building on: ${CMAKE_HOST_SYSTEM_NAME} ${CMAKE_HOST_SYSTEM_VERSION}")

# allowed configuration types
set(CMAKE_CONFIGURATION_TYPES Debug Release RelWithDebInfo)

# use project folders in IDE's
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# include this module directory
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_LIST_DIR}")

# include macros
include(CreateTarget)
include(MacroEnsureOutOfSourceBuild)
include(ProjectSetupFunctions)

# ensure out of source builds
EnsureOutOfSourceBuild()

# setup folder where generated files should go
set(PROJECT_GENERATED_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated)
file(MAKE_DIRECTORY "${PROJECT_GENERATED_DIR}")
include_directories(${PROJECT_GENERATED_DIR})

# handle configuration types
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Set the CMake configuration type to use")
message(STATUS "Using configuration type: ${CMAKE_BUILD_TYPE}")
set(CMAKE_CONFIGURATION_TYPES ${CMAKE_BUILD_TYPE})

if ("${CMAKE_BUILD_TYPE}" STREQUAL "")
    message(FATAL_ERROR "Configuration type is empty, please explicitly specify the configuration type to use. (Debug Release RelWithDebInfo)")
endif()

# set position independent code for languages and targets which support it
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# shared library configuration
set(CMAKE_INSTALL_RPATH "${ORIGIN}")
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)

# release mode flags
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O2 -DNDEBUG")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O2 -DNDEBUG")
set(CMAKE_D_FLAGS_RELEASE "${CMAKE_D_FLAGS_RELEASE} -O2")

# generic build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -Wno-unknown-pragmas -Wno-switch -Wno-unused-command-line-argument")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -Wno-unknown-pragmas -Wno-switch -Wno-unused-command-line-argument")

# prevent implicit function declarations and treat them as errors
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror=implicit-function-declaration")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=implicit-function-declaration")

# C/C++: debugger tuning when in debug mode
# Debug mode flags
if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    message(STATUS "Building with development configuration.")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DDEBUG_BUILD")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDEBUG_BUILD")
    # note: for D the language support already adds debug arguments
endif()

# call this after a project was initialized
macro(ProjectSetupDetectAdditionalDebugOptions)
    ProjectSetupClangDebuggerTuningC()
    ProjectSetupClangDebuggerTuningCxx()
endmacro()

# enable debugger tuning if the compiler was already identified (ProjectSetup called after project)
if (NOT "${CMAKE_C_COMPILER_ID}" STREQUAL "")
    ProjectSetupClangDebuggerTuningC()
endif()
if (NOT "${CMAKE_CXX_COMPILER_ID}" STREQUAL "")
    ProjectSetupClangDebuggerTuningCxx()
endif()

# set target destination for built targets
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib-static)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# DEBUG: print flags
#message(STATUS "C: ${CMAKE_C_FLAGS}")
#message(STATUS "C++: ${CMAKE_CXX_FLAGS}")
#message(STATUS "D: ${CMAKE_D_FLAGS}")
