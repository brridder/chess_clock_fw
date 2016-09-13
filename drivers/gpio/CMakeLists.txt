cmake_minimum_required(VERSION 3.6)

create_library(
    NAME
        gpio
    SOURCES
        src/gpio.c
    INCLUDE_DIR
        inc
    LIBRARIES
        mkl25z4
)

