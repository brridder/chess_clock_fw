cmake_minimum_required(VERSION 3.6)

create_library(
    NAME
        bsp_frdm_kl25z
    SOURCES
        src/bsp.c
        src/bsp_led.c
    INCLUDE_DIR
        inc
    LIBRARIES
        mkl25z4
        gpio
)
