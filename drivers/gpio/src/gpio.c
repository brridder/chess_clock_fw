#include "driver/gpio.h"

#include <MKL25Z4.h>

enum {
    LED_GREEN_PIN = 19,
    LED_RED_PIN = 18,
    LED_BLUE_PIN = 1,
};

typedef struct gpio_table_t {
    uint8_t pin;
    GPIO_Type *gpio;
    PORT_Type *port;
    uint8_t mux;
} gpio_table_t;

static gpio_table_t gpio_table[3] = {
    { .pin = 19, .gpio = GPIOB, .port = PORTB, .mux = 1 },
    { .pin = 18, .gpio = GPIOB, .port = PORTB, .mux = 1 },
    { .pin = 1,  .gpio = GPIOD, .port = PORTD, .mux = 1 },
};

void gpio_init()
{
    SIM->SCGC5 |= (SIM_SCGC5_PORTB(1) | SIM_SCGC5_PORTD(1));
    for (int i = 0; i < 3; i++) {
        gpio_table[i].port->PCR[gpio_table[i].pin] = PORT_PCR_MUX(gpio_table[i].mux);
        gpio_table[i].gpio->PDDR |= (1 << gpio_table[i].pin);
    }
}

void gpio_set(uint8_t pin)
{
    gpio_table[pin].gpio->PSOR |= (1 << gpio_table[pin].pin);
}

void gpio_clear(uint8_t pin)
{
    gpio_table[pin].gpio->PCOR |= (1 << gpio_table[pin].pin);

}
void gpio_toggle(uint8_t pin)
{
    gpio_table[pin].gpio->PTOR |= (1 << gpio_table[pin].pin);
}

