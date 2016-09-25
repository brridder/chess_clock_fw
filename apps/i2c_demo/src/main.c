#include <bsp/bsp.h>
#include <bsp/bsp_led.h>

#include <driver/watchdog.h>
#include <driver/i2c.h>

#include <MKL25Z4.h>
#include <assert.h>

void delay(void)
{
    volatile int i = 1000000;
    while (i--) {}
}
int main(void)
{
    bsp_init();
    bsp_led_init();
    watchdog_disable();
    
    i2c_init(I2C0);

    bsp_led_set(BSP_LED_GREEN);
    bsp_led_set(BSP_LED_BLUE);
    bsp_led_set(BSP_LED_RED);
    while(1) {
        bsp_led_toggle(BSP_LED_GREEN);
        delay();
    }
    return 1;
}
