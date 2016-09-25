#include "bsp/bsp.h"

#include <driver/clock.h>

void bsp_init(void)
{
    clock_init();
}
