file(GLOB_RECURSE PANS_SOURCES CONFIGURE_DEPENDS *.cpp *.cc *.c)
file(GLOB_RECURSE PANS_HEADERS CONFIGURE_DEPENDS *.h *.hpp)

add_library(pans STATIC ${PANS_SOURCES} ${PANS_HEADERS})

target_include_directories(pans
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(pans PUBLIC pans_options)