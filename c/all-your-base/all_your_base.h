#ifndef ALL_YOUR_BASE_H
#define ALL_YOUR_BASE_H

#include <inttypes.h>
#include <math.h>
#include <string.h>

#define DIGITS_ARRAY_SIZE (64)

size_t rebase(int8_t *input_sequence, int16_t input_base, int16_t output_base,
              size_t input_length);

#endif
