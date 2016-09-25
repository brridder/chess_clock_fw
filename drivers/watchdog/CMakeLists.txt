cmake_minimum_required(VERSION 3.6)

create_library(
    NAME
        watchdog
    SOURCES
        src/watchdog.c
    INCLUDE_DIR
        inc
    LIBRARIES
        mkl25z4
)

