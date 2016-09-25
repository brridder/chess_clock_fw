#pragma once

#include <driver/gpio.h>

typedef enum bsp_led_t{
    BSP_LED_GREEN = GPIO_PORTB_PIN_18,
    BSP_LED_RED = GPIO_PORTB_PIN_19,
    BSP_LED_BLUE = GPIO_PORTD_PIN_1,
} bsp_led_t;

void bsp_led_init(void);
void bsp_led_set(bsp_led_t led);
void bsp_led_clear(bsp_led_t led);
void bsp_led_toggle(bsp_led_t led);
