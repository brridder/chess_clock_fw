#pragma once

typedef enum watchdog_clock_src_t {
    WATCHDOG_CLOCK_SRC_INTERNAL_1KHZ_LPO = 0,
    WATCHDOG_CLOCK_SRC_BUS_CLOCK = 1,
} watchdog_clock_src_t;

typedef enum watchdog_clock_timeout_t {
    WATCHDOG_CLOCK_TIMEOUT_32_LPO_OR_8192_BUS_CLOCK_CYCLES = 0b01,
    WATCHDOG_CLOCK_TIMEOUT_256_LPO_OR_65536_BUS_CLOCK_CYCLES = 0b10,
    WATCHDOG_CLOCK_TIMEOUT_1024_LPO_OR_262144_BUS_CLOCK_CYCLES = 0b11,
} watchdog_clock_timeout_t;

void watchdog_init(watchdog_clock_src_t src, watchdog_clock_timeout_t timeout);
void watchdog_disable(void);
void watchdog_kick(void);
