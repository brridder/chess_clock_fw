#include <MKL25Z4.h>

void delay(void) {

    volatile int i = 2000000;
    while (i--) {}
}

int main(void)
{
    // RED is PTB18
    // BLUE is PTD1
    // GREEN is PTB19

    SIM->SCGC5 |= SIM_SCGC5_PORTB(1) & SIM_SCGC5_PORTD(1);
    GPIOB->PDDR |= (1 << 18) & (1 << 19);
    GPIOD->PDDR |= (1 << 1);

    while(1) {
        GPIOB->PTOR |= (1 << 18);
        delay();
        GPIOB->PTOR |= (1 << 19);
        delay();
        GPIOD->PTOR |= (1 << 1);
        delay();
    }
    return 1;
}
