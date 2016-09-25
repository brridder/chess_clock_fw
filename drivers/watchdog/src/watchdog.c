#include "driver/watchdog.h"

#include <MKL25Z4.h>

void watchdog_init(watchdog_clock_src_t src, watchdog_clock_timeout_t timeout)
{
    SIM->COPC = SIM_COPC_COPT(timeout) | SIM_COPC_COPCLKS(src) | SIM_COPC_COPW(0);
}

void watchdog_disable(void)
{
    SIM->COPC = 0;
}

void watchdog_kick(void)
{
    SIM->SRVCOP = 0x55;
    SIM->SRVCOP = 0xAA;
}
