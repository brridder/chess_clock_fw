#include <MKL25Z4.h>
#include <assert.h>

enum {
    LED_GREEN_PIN = 19,
    LED_RED_PIN = 18,
    LED_BLUE_PIN = 1,
};

typedef enum led_t{
    LED_GREEN = 0,
    LED_RED,
    LED_BLUE,

    LED_COUNT
} led_t;

typedef struct led_table {
    uint8_t pin;
    GPIO_Type *gpio;
    PORT_Type *port;
    uint8_t mux;
} led_table_t;

static led_table_t led_table[LED_COUNT] = {
    { .pin = LED_GREEN_PIN, .gpio = GPIOB, .port = PORTB, .mux = 1 },
    { .pin = LED_RED_PIN, .gpio = GPIOB, .port = PORTB, .mux = 1 },
    { .pin = LED_BLUE_PIN, .gpio = GPIOD, .port = PORTD, .mux = 1 },
};

void delay(void)
{
    volatile int i = 1000000;
    while (i--) {}
}

void disable_wdog(void)
{
    SIM->COPC = 0;
}

void init_leds(void) {
    SIM->SCGC5 |= (SIM_SCGC5_PORTB(1) | SIM_SCGC5_PORTD(1));
    for (int i = 0; i < sizeof(led_table)/sizeof(led_table[0]); i++) {
        led_table[i].port->PCR[led_table[i].pin] = PORT_PCR_MUX(led_table[i].mux);
        led_table[i].gpio->PDDR |= (1 << led_table[i].pin);
    }
}

void led_set(led_t led) {
    led_table[led].gpio->PSOR |= (1 << led_table[led].pin);
}

void led_clear(led_t led) {
    led_table[led].gpio->PCOR |= (1 << led_table[led].pin);
}

void led_toggle(led_t led) {
    led_table[led].gpio->PTOR |= (1 << led_table[led].pin);
}

int main(void)
{
    disable_wdog();

    init_leds();

    led_set(LED_GREEN);
    led_set(LED_RED);
    led_set(LED_BLUE);
    while(1) {
        led_toggle(LED_GREEN);
        delay();
        led_toggle(LED_RED);
        delay();
        led_toggle(LED_BLUE);
        delay();
    }
    return 1;
}
