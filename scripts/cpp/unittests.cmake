# unit tests
CreateTargetFromPath(tests "tests" EXECUTABLE "tests" C++ 20)

# unit testing framework
target_include_directories(tests SYSTEM PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/bandit")

target_link_libraries(tests PRIVATE
)
