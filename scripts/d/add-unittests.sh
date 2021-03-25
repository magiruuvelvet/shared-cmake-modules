#!/bin/sh

# unit testing framework
DUNIT_REPO="https://github.com/linkrope/dunit"
UNDEAD_REPO="https://github.com/dlang/undead"

# checkout unit testing framework submodules
mkdir -p tests/dunit
git submodule add "$DUNIT_REPO" tests/dunit/dunit
git submodule add "$UNDEAD_REPO" tests/dunit/undead

# bootstrap unit test main and an example test to get started
mkdir -p tests/tests
cp cmake/modules/scripts/d/unittests.cmake tests/CMakeLists.txt

cat << EOF > tests/tests/main.d
module tests.main;

import dunit;

int main(string[] args)
{
    return dunit_main(args);
}
EOF

cat << EOF > tests/tests/example.d
module tests.example;

import dunit;

@Tag("MyTest")
class MyTest
{
    mixin UnitTest;

    @Test
    @Tag("MyTest.myTest")
    void myTest()
    {
    }
}
EOF
