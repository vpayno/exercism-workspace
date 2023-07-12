#include "resistor_color_duo.h"

unsigned int color_code(const resistor_band_t bands[]) {
    unsigned int resistor_value = 0;

    // get the value of the first band
    resistor_value = bands[0] * 10;

    // get the value of the second band
    resistor_value += bands[1];

    return resistor_value;
}
