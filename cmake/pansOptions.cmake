# 接口库，不产生任何编译产物，仅传递编译选项
add_library(pans_options INTERFACE)

target_compile_options(pans_options INTERFACE
    # gcc/clang 通用选项
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:
        -Wall       # 常用警告
        -Wextra     # 额外警告（比 -Wall 更严格）
        -Wpedantic  # 严格遵循标准
        -fno-strict-aliasing # 关闭严格别名规则，不同别名的指针可以相互赋值，允许数值精度降低，如float->int
    >
)

target_compile_options(pans_options INTERFACE
    $<$<AND:$<PLATFORM_ID:Linux>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:
    -fPIC # 编译位置无关，防止链接报错
    >
)

target_link_options(pans_options INTERFACE
    $<$<AND:$<PLATFORM_ID:Linux>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:
    -rdynamic   # 栈回溯需要
    >
)

target_compile_definitions(pans_options INTERFACE
    $<$<CONFIG:Debug>:PANS_DEBUG>   # 避免win宏污染
)

target_compile_options(pans_options INTERFACE
    $<$<CONFIG:Debug>:-O0>  # 不优化
    $<$<CONFIG:Debug>:-g3>  # 生成更完整调试信息
    $<$<CONFIG:Debug>:-ggdb> # 生成适用于gdb的调试信息
)

# ===== Release/RelWithDebInfo 共用选项 =====
target_compile_options(pans_options INTERFACE
    $<$<CONFIG:Release>:-DNDEBUG>
    $<$<CONFIG:Release>:-O2>    # O2优化
    $<$<CONFIG:Release>:-fno-omit-frame-pointer>    # 保留栈指针
    
    $<$<CONFIG:RelWithDebInfo>:-DNDEBUG>
    $<$<CONFIG:RelWithDebInfo>:-O2>
    $<$<CONFIG:RelWithDebInfo>:-g>
    $<$<CONFIG:RelWithDebInfo>:-fno-omit-frame-pointer>
)

# 覆盖率工具
option(ENABLE_COVERAGE "Enable code coverage instrumentation" OFF)
if(ENABLE_COVERAGE)
    target_compile_options(pans_options INTERFACE
        $<$<CONFIG:Debug>:--coverage>
    )
    target_link_options(pans_options INTERFACE
        $<$<CONFIG:Debug>:--coverage>
    )
endif()