cmake_minimum_required(VERSION 3.0)

project(merkletree)

include(FeatureSummary)

SET(CMAKE_CXX_FLAGS "-std=c++1y -Wall")
SET(CMAKE_CXX_FLAGS_RELEASE "-O3")
SET(CMAKE_CXX_FLAGS_DEBUG   "-g -Wextra -O0 -fdiagnostics-color")
SET(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)

include(cmake/functions.cmake)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

ENUM(BUILD "${BUILD}" "library build type"
    SHARED
    STATIC
)

if(NOT BUILD)
    set(BUILD  "SHARED")
endif()

add_library(merkletree ${BUILD}
    src/merkle_tree_math.cc
    src/merkle_tree.cc
    src/tree_hasher.cc)

install(TARGETS merkletree
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib/static
  CONFIGURATIONS Release
)



# enable_testing()
# add_subdirectory(test)
