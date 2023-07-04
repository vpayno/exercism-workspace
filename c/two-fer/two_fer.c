#include "two_fer.h"
#include <assert.h>
#include <stdio.h>

void two_fer(char *buffer, const char *name) {
    const char *for_name = name ? name : "you";
    int size = sprintf(buffer, "One for %s, one for me.", for_name);

    assert(size > 0);
}
