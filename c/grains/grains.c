#include "grains.h"
#include <math.h>

uint64_t square(uint8_t index) {
    const uint8_t index_min = 1;
    const uint8_t index_max = 64;

    if (index < index_min || index > index_max) {
        return (uint64_t)0;
    }

    return (uint64_t)1 << (uint8_t)(index - 1);
}

uint64_t total() {
    /* The result of the left shift is undefined due to shifting by '64', which
    is greater or equal to the width of type 'uint64_t' return (uint64_t)1 <<
    64;
    */
    return (((1UL << (uint8_t)63) - (uint8_t)1) << (uint8_t)1) + 1;
}
