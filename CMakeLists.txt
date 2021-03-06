cmake_minimum_required(VERSION 3.6)

include(${CMAKE_SOURCE_DIR}/cmake/create_library.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/create_application.cmake)

if (BUILD_HOST)
    project(host C CXX)

    set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/../bin/${CMAKE_BUILD_TYPE}/Host)
elseif (BUILD_TARGET)
    set(CMAKE_TOOLCHAIN_FILE cmake/gcc-arm.toolchain.cmake)

    project(target C ASM)

    include(cmake/mkl25z4.cmake)

    set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR}/../bin/${CMAKE_BUILD_TYPE}/Target)
    add_subdirectory(devices)
    add_subdirectory(drivers)
    add_subdirectory(bsp)
    add_subdirectory(libraries)
    add_subdirectory(apps)
endif()
