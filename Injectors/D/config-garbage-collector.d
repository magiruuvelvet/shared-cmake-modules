module cmake.config.gc;

// https://dlang.org/spec/garbage.html

// test with --DRT-gcopt=help and DRT_GCOPT=help

// disable DRuntime built-in command line arguments
extern(C) __gshared bool rt_cmdline_enabled = false;

// disable DRuntime built-in environment variables
extern(C) __gshared bool rt_envvars_enabled = false;

// default GC options can be controlled with
// extern(C) __gshared string[] rt_options = [ "gcopt=initReserve:100 profile:1" ];

// use d_install_injectors(target) from CMake if you want to disable user
// configurable GC options and enforce defaults or provide your own
