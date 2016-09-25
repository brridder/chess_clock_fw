#include <bsp/bsp_led.h>
#include <driver/gpio.h>

//enum {
    //LED_GREEN_PIN = 19,
    //LED_RED_PIN = 18,
    //LED_BLUE_PIN = 1,
//};

//typedef struct led_table {
    //uint8_t pin;
    //GPIO_Type *gpio;
    //PORT_Type *port;
    //uint8_t mux;
//} led_table_t;

//static led_table_t led_table[BSP_LED_COUNT] = {
    //{ .pin = LED_GREEN_PIN, .gpio = GPIOB, .port = PORTB, .mux = 1 },
    //{ .pin = LED_RED_PIN, .gpio = GPIOB, .port = PORTB, .mux = 1 },
    //{ .pin = LED_BLUE_PIN, .gpio = GPIOD, .port = PORTD, .mux = 1 },
//};

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
