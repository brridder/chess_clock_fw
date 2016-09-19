cmake_minimum_required(VERSION 3.6)

create_library(
    NAME
        mkl46z4
    SOURCES
        src/startup_MKL46Z4.S
    INCLUDE_DIR
        inc
    LIBRARIES
        CMSIS
)
