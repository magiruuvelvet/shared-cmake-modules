cmake_minimum_required(VERSION 3.14)

project(cxx-test CXX)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../..")

include(CreateTarget)

CreateTarget(cxx-test EXECUTABLE cxx-test C++ 14)

message(STATUS "${CMAKE_MODULE_PATH}")
