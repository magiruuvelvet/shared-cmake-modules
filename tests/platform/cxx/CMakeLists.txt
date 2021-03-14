cmake_minimum_required(VERSION 3.14)

project(cxx-platform-test CXX)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../../..")

include(CreateTarget)
include(ProjectSetupFunctions)

CreateTarget(cxx-platform-test EXECUTABLE cxx-platform-test C++ 14)
ProjectSetupRegisterPlatformMacros(cxx-platform-test)

message(STATUS "${CMAKE_MODULE_PATH}")
