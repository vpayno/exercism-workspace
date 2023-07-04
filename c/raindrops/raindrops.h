#ifndef RAINDROPS_H
#define RAINDROPS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define RESULT_SIZE 16

char *convert(char result[], int drops);

enum sounds {
    PLING = 3,
    PLANG = 5,
    PLONG = 7,
};

static const char *const sound_names[] = {
    [PLING] = "Pling",
    [PLANG] = "Plang",
    [PLONG] = "Plong",
};

#endif
