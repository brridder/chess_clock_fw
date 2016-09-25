cmake_minimum_required(VERSION 3.6)

create_library(
    NAME
        i2c
    SOURCES
        src/i2c.c
    INCLUDE_DIR
        inc
    LIBRARIES
        clock
        mkl25z4
)

