#!/bin/sh

# unit testing framework
BANDIT_REPO="https://github.com/banditcpp/bandit"

# checkout unit testing framework submodules
mkdir -p tests
git submodule add "$BANDIT_REPO" tests/bandit
pushd tests/bandit 2>&1 >/dev/null
git submodule init
git submodule update
popd 2>&1 >/dev/null

# bootstrap unit test main and an example test to get started
mkdir -p tests/tests
cp cmake/modules/scripts/cpp/unittests.cmake tests/CMakeLists.txt

cat << EOF > tests/tests/main.cpp
#include <bandit/bandit.h>

#include "example.hpp"

int main(int argc, char **argv)
{
    return bandit::run(argc, argv);
}
EOF

cat << EOF > tests/tests/example.hpp
#include <bandit/bandit.h>

using namespace snowhouse;
using namespace bandit;

go_bandit([]{
    describe("MyTest", []{
        it("[myTest]", [&]{
        });
    });
});
EOF
