cmake_minimum_required(VERSION 3.14)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../..")

project(module NONE)
include(ProjectSetup)
include(EnableD)

# check if the module path can be extended after using EnableD
# due to usage of CACHE FORCE
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}"
    "${PROJECT_SOURCE_DIR}/somepath1"
    "${PROJECT_SOURCE_DIR}/somepath2"
)

message(STATUS "${CMAKE_MODULE_PATH}")
