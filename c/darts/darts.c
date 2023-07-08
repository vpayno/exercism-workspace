#include "darts.h"

uint8_t score(coordinate_t position) {
    float distance = hypotf(position.x, position.y);

    if (distance <= 1.0F) {
        return 10;
    }

    if (distance <= 5.0F) {
        return 5;
    }

    if (distance <= 10.0F) {
        return 1;
    }

    return 0;
}
