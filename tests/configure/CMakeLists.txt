cmake_minimum_required(VERSION 3.14)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../..")

include(EnableD)

project(configure-test CXX D)
include(ProjectSetup)

set(CMAKE_SOME_VALUE "hello")
CreateTarget(configure-test-1 EXECUTABLE configure-test-1 C++ 14)
CreateTarget(configure-test-2 EXECUTABLE configure-test-2 D 2)

ProjectConfigureFile(configure-test-1 "conf/cpp-conf.hpp")
ProjectConfigureFile(configure-test-2 "configured.d")

message(STATUS "${CMAKE_MODULE_PATH}")
