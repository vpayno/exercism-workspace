#include "grains.h"
#include <math.h>

uint64_t square(uint8_t index) {
    const uint8_t index_min = 1;
    const uint8_t index_max = 64;

    if (index < index_min || index > index_max) {
        return (uint64_t)0;
    }

    return (uint64_t)pow(2, index - 1);
}

uint64_t total() { return (uint64_t)pow(2, 64); }
