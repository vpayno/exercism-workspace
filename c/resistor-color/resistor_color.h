#ifndef RESISTOR_COLOR_H
#define RESISTOR_COLOR_H

typedef enum {
    BLACK = 0,
    BROWN,
    RED,
    ORANGE,
    YELLOW,
    GREEN,
    BLUE,
    VIOLET,
    GREY,
    WHITE,
    NUMBER_OF_COLORS,
} resistor_band_t;

resistor_band_t color_code(resistor_band_t color);

const resistor_band_t *colors(void);

#endif
