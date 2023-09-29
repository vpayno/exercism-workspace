#ifndef MATCHING_BRACKETS_H
#define MATCHING_BRACKETS_H

#include <stdbool.h>

typedef unsigned int usize_t;

bool is_paired(const char *input);
bool bracket_match(char open_bracket, char close_bracket);
bool bracket_open(char bracket);
bool bracket_close(char bracket);
bool bracket_either(char bracket);

#endif
