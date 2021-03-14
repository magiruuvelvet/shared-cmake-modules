cmake_minimum_required(VERSION 3.14)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../../..")

include(EnableD)

project(d-platform-test D)

include(CreateTarget)
include(ProjectSetupFunctions)

CreateTarget(d-platform-test EXECUTABLE d-platform-test D 2)

# should not affect anything since this macro doesn't touch D compiler flags
ProjectSetupRegisterPlatformMacros(d-platform-test)

message(STATUS "${CMAKE_MODULE_PATH}")
