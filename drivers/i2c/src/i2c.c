#include "driver/i2c.h"

#include <driver/clock.h>

#include <MKL25Z4.h>

// MULT 00 -> 1
// MULT 01 -> 2
// MULT 10 -> 4
// MULT 11 -> Reserved

/*
 * 1. Write: Frequency Divider register to set the I2C baud rate (see example in description of ICR)
 * 2. Write: Control Register 1 to enable the I2C module and interrupts
 * 3. Initialize RAM variables (IICEN = 1 and IICIE = 1) for transmit data
 * 4. Initialize RAM variables used to achieve the routine shown in the following figure
 * 5. Write: Control Register 1 to enable TX
 * 6. Write: Control Register 1 to enable MST (master mode)
 * 7. Write: Data register with the address of the target slave (the LSB of this byte
 *           determines whether the communication is master receive or transmit)
 */

void i2c_init(I2C_Type *i2c)
{
    //uint32_t bus_clock = clock_get_bus_clock_speed_hz();

    SIM->SCGC4 |= SIM_SCGC4_I2C0(1);
    SIM->SCGC5 |= SIM_SCGC5_PORTC(1);
    PORTC->PCR[8] = PORT_PCR_MUX(0b010);
    PORTC->PCR[9] = PORT_PCR_MUX(0b010);
// Bus speed = 12MHz
//
// 100kpbs =  12E6 / (4 x 40);
// I2C baud rate = bus speed (Hz)/(mul × SCL divider)
//
// SDA hold time = (1/12E6)*4*9 = 0.000003 = 3e-6 S = 3 uS
// SDA hold time = bus period (s) × mul × SDA hold value
//
// SCL Start hold time = (1/12E6)*4*16 = 5.33 uS
// SCL start hold time = bus period (s) × mul × SCL start hold value
//
// SCL stop hold time = (1/12E6)*4*21 =  7 uS
// SCL stop hold time = bus period (s) × mul × SCL stop hold value

    i2c->F = I2C_F_ICR(0x0b) | I2C_F_MULT(0b10);
    i2c->C1 = I2C_C1_IICEN(1) | I2C_C1_IICIE(1) | I2C_C1_MST(1) | I2C_C1_TX(1);
    i2c->D = 0x70;
    while (((i2c->S & I2C_S_TCF_MASK) >> I2C_S_TCF_SHIFT) != 1) {}
    i2c->D = 0x21;
    while (((i2c->S & I2C_S_TCF_MASK) >> I2C_S_TCF_SHIFT) != 1) {}
}

