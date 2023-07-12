#include "resistor_color_trio.h"

resistor_value_t color_code(const resistor_band_t bands[]) {

    resistor_value_t resistor_value;
    resistor_value.unit = OHMS;

    // get the value of the first band
    resistor_value.value = bands[0] * 10;

    // get the value of the second band
    resistor_value.value += bands[1];

    // get the value of the third band
    resistor_value.value *= (unsigned int)pow(10, bands[2]);

    if (resistor_value.value >= 1000) {
        resistor_value.value /= 1000;
        resistor_value.unit = KILOOHMS;
    }

    return resistor_value;
}
