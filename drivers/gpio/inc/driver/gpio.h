#pragma once

typedef enum gpio_port_t {
    GPIO_PORT_A = 0,
    GPIO_PORT_B,
    GPIO_PORT_C,
    GPIO_PORT_D,
    GPIO_PORT_E,
} gpio_port_t;

typedef struct gpio_pin_t {
    int t;
} gpio_pin_t;

typedef struct gpio_config_gpio_config_t {
    gpio_port_t port;

} gpio_config_t;

void gpio_init(void);

void gpio_set(gpio_pin_t pin);
void gpio_clear(gpio_pin_t pin);

