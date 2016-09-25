#include "driver/clock.h"

#include <MKL25Z4.h>

/*
 * Assuming 8 MHz source clock.
 */

static uint32_t system_clock_speed;
static uint32_t bus_clock_speed;

static void osc_init(void)
{
    OSC0->CR |= OSC_CR_ERCLKEN(1);
}

static void clock_fei_to_fbe(void)
{
    MCG->C2 = MCG_C2_RANGE0(0b11) | MCG_C2_EREFS0(1) | MCG_C2_HGO0(1);
    //MCG->C1 &= ~MCG_C1_IREFS(1);

    // FRDIV needs to be set so that FLL ref clock is between 31.25 kHz to 39.0615 kHz.
    // Ext ref = 8MHz.
    // FRDIV(0b011) = 256
    // FLL Ref Clock = 8 MHz / 256 = 32.125 kHz

    MCG->C1 = MCG_C1_CLKS(0b10) | MCG_C1_FRDIV(0b011);

    while ((MCG->S & MCG_S_OSCINIT0(1)) == 0) {} // Loop until OSCINIT0 is set
    while ((MCG->S & MCG_S_IREFST(1)) != 0) {} // Loop until IRFSET is cleared
    while ((MCG->S & MCG_S_CLKST(0b10)) == 0) {} // Loop until external CLKST is selected
}

static void clock_fbe_to_pbe(void)
{
    // Divide 8Mhz down to 2MHz (PRDIV0 factor of 4)
    MCG->C5 |= MCG_C5_PRDIV0(0b011);

    // PLLS(1) to select PLL
    // VDIV0(0) to multiply 2MHz ref by 24
    MCG->C6 |= MCG_C6_PLLS(1) | MCG_C6_VDIV0(0);

    while ((MCG->S & MCG_S_PLLST(1)) == 0) {} // Loop until PLLST is set
    while ((MCG->S & MCG_S_LOCK0(1)) == 0) {} // Loop until PLL has acquired a lock
}

static void clock_pbe_to_pee(void)
{
    MCG->C1 &= ~MCG_C1_CLKS(0b11); // Clear CLKS to select PLL as system clock source
    while (((MCG->S & MCG_S_CLKST_MASK) >> MCG_S_CLKST_SHIFT) != 0x3) {}
    while (!(MCG->S & MCG_S_LOCK0_MASK)) {}
}

void clock_init(void)
{
    osc_init();

    // OUTDIV1 for core/system clocks + bus/flash clocks
    // OUTDIV4 for bus and flash clock and in addition to the system clock divide ratio.
    // Core/System clocks: 48 MHz
    // Bus/Flash clocks: 48 MHz/4 = 12MHz  (To prevent core lockups)
    SIM->CLKDIV1 = SIM_CLKDIV1_OUTDIV1(0) | SIM_CLKDIV1_OUTDIV4(0b011);

    clock_fei_to_fbe();
    clock_fbe_to_pbe();
    clock_pbe_to_pee();

    system_clock_speed = 48000000;
    bus_clock_speed = 12000000;
}

uint32_t clock_get_system_clock_speed_hz(void)
{
    return system_clock_speed;
}

uint32_t clock_get_bus_clock_speed_hz(void)
{
    return bus_clock_speed;
}
