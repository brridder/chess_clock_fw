#pragma once

typedef enum bsp_led_t{
    BSP_LED_GREEN = 0,
    BSP_LED_RED,
    BSP_LED_BLUE,

    BSP_LED_COUNT
} bsp_led_t;

void bsp_led_init(void);
void bsp_led_set(bsp_led_t led);
void bsp_led_clear(bsp_led_t led);
void bsp_led_toggle(bsp_led_t led);
