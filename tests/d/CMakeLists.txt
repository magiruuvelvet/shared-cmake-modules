set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../..")

include(EnableD)

project(c-test D)

include(CreateTarget)

CreateTarget(d-test EXECUTABLE d-test D 2)

message(STATUS "${CMAKE_MODULE_PATH}")
