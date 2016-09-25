#include <bsp/bsp.h>
#include <bsp/bsp_led.h>

#include <driver/watchdog.h>

#include <MKL25Z4.h>
#include <assert.h>

void delay(void)
{
    volatile int i = 5000000;
    while (i--) { }
}

void disable_wdog(void)
{
    SIM->COPC = 0;
}


int main(void)
{
    bsp_init();
    watchdog_init(WATCHDOG_CLOCK_SRC_INTERNAL_1KHZ_LPO, WATCHDOG_CLOCK_TIMEOUT_1024_LPO_OR_262144_BUS_CLOCK_CYCLES);
    bsp_led_init();

    bsp_led_set(BSP_LED_GREEN);
    bsp_led_set(BSP_LED_RED);
    bsp_led_set(BSP_LED_BLUE);
    watchdog_kick();
    while(1) {
        bsp_led_toggle(BSP_LED_GREEN);
        watchdog_kick();
        delay();
        bsp_led_toggle(BSP_LED_RED);
        watchdog_kick();
        delay();
        bsp_led_toggle(BSP_LED_BLUE);
        watchdog_kick();
        delay();
    }
    return 1;
}
