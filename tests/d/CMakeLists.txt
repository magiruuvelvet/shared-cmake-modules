project(c-test D)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_SOURCE_DIR}/../..")

include(CreateTarget)

CreateTarget(d-test EXECUTABLE d-test D 2)

message(STATUS "${CMAKE_MODULE_PATH}")
