#include <bsp/bsp_led.h>

void bsp_led_init(void)
{
    gpio_init();
}

void bsp_led_set(bsp_led_t led)
{
    gpio_set(led);
}

void bsp_led_clear(bsp_led_t led)
{
    gpio_clear(led);
}

void bsp_led_toggle(bsp_led_t led)
{
    gpio_toggle(led);
}
