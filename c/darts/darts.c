#include "darts.h"

uint8_t score(coordinate_t position) {
    // Figure out where the dart landed using it's (x, y) coordinate.
    // r^2 = (x – h)^2 + (y – k)^2
    double radius = sqrt(pow(position.x - 0, 2) + pow(position.y - 0, 2));

    if (radius > 5 && radius <= 10) {
        return 1;
    }

    if (radius > 1 && radius <= 5) {
        return 5;
    }

    if (radius <= 1) {
        return 10;
    }

    return 0;
}
