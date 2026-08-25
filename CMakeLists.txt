cmake_minimum_required(VERSION 3.25)

# 防止多版本编译器冲突，覆盖cmake缓存
set(CMAKE_C_COMPILER "/usr/bin/gcc" CACHE FILEPATH "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "/usr/bin/g++" CACHE FILEPATH "C++ compiler" FORCE)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(pans LANGUAGES C CXX)

include(GNUInstallDirs) # 使用GUN标准目录，防止硬编码
include(CMakePackageConfigHelpers) # 此项目编译成库能正确被别的项目引用

# 编译项目选项
option(PANS_BUILD_EXAMPLES "Build examples" ON)
option(PANS_BUILD_TESTS    "Build tests"    ON)
option(PANS_BUILD_TOOLS    "Build tools"    ON)

# 若多配置生成器和单配置生成器都没有
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
endif()
# 图形界面选项
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release RelWithDebInfo MinSizeRel)
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")

# 并行编译数量
cmake_host_system_information(RESULT CPU_NUMS QUERY NUMBER_OF_LOGICAL_CORES)
message(STATUS "CPU NUMS on current server is: ${CPU_NUMS}")
math(EXPR JOBS "${CPU_NUMS} + ${CPU_NUMS} / 2")
set(CMAKE_BUILD_PARALLEL_LEVEL ${JOBS} CACHE STRING "Number of parallel compilation threads")
message(STATUS "Compiler default work jobs: ${CMAKE_BUILD_PARALLEL_LEVEL}")

include(cmake/pansOptions.cmake)

add_subdirectory(pans)
if(PANS_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
if(PANS_BUILD_TOOLS)
    add_subdirectory(tools)
endif()
