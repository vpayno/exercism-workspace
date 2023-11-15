#include "resistor_color.h"

resistor_band_t color_code(resistor_band_t color) { return color; }

const resistor_band_t *colors(void) {
    static resistor_band_t colors_list[NUMBER_OF_COLORS] = {BLACK};

    for (int i = 0; i < NUMBER_OF_COLORS; i++) {
        colors_list[i] = (resistor_band_t)i;
    }

    return colors_list;
}
