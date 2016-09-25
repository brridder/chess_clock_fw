#pragma once

#include <stdint.h>

void clock_init(void);
uint32_t clock_get_system_clock_speed_hz(void);
uint32_t clock_get_bus_clock_speed_hz(void);

