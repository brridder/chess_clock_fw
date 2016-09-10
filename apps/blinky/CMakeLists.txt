cmake_minimum_required(VERSION 3.6)

create_application(
    NAME
        blinky
    SOURCES
        src/main.c
    LINKER_SCRIPT
        ${CMAKE_SOURCE_DIR}/devices/mkl25z4/linker/MKL25Z128xxx4_flash.ld
    LIBRARIES
        mkl25z4
)
