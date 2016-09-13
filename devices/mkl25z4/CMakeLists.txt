cmake_minimum_required(VERSION 3.6)

create_library(
    NAME
        mkl25z4
    SOURCES
        src/startup_MKL25Z4.S
    INCLUDE_DIR
        inc
        CMSIS/Include
    LIBRARIES
)
