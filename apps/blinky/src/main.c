#include <bsp/bsp_led.h>

#include <MKL25Z4.h>
#include <assert.h>

void delay(void)
{
    volatile int i = 1000000;
    while (i--) {}
}

void disable_wdog(void)
{
    SIM->COPC = 0;
}

int main(void)
{
    disable_wdog();

    bsp_led_init();

    bsp_led_set(BSP_LED_GREEN);
    bsp_led_set(BSP_LED_RED);
    bsp_led_set(BSP_LED_BLUE);
    while(1) {
        bsp_led_toggle(BSP_LED_GREEN);
        delay();
        bsp_led_toggle(BSP_LED_RED);
        delay();
        bsp_led_toggle(BSP_LED_BLUE);
        delay();
    }
    return 1;
}
