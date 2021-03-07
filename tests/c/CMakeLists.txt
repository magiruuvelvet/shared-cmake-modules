cmake_minimum_required(VERSION 3.14)

project(c-test C)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../..")

include(CreateTarget)

CreateTarget(c-test EXECUTABLE c-test C 11)

message(STATUS "${CMAKE_MODULE_PATH}")
