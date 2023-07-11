#include "bob.h"

char *hey_bob(char *greeting) {

    regex_t re_comp;
    int regex_compile_result = 0;

    // Silence.
    regex_compile_result = regcomp(&re_comp, "^[[:space:]]*$", REG_EXTENDED);
    if (regex_compile_result) {
        (void)fprintf(stderr, "Could not compile regex\n");
        abort();
    }
    regex_compile_result = regexec(&re_comp, greeting, 0, NULL, 0);
    regfree(&re_comp);
    if (!regex_compile_result) {
        return "Fine. Be that way!";
    }

    // Question with only spaces and punctuation.
    regex_compile_result =
        regcomp(&re_comp, "^([[:punct:]|[[:space:]])+[?]$", REG_EXTENDED);
    if (regex_compile_result) {
        (void)fprintf(stderr, "Could not compile regex\n");
        abort();
    }
    regex_compile_result = regexec(&re_comp, greeting, 0, NULL, 0);
    regfree(&re_comp);
    if (!regex_compile_result) {
        return "Sure.";
    }

    // Question with uppercase letters, punctuation and spaces.
    regex_compile_result = regcomp(
        &re_comp, "^([[:upper:]]|[[:punct:]|[[:space:]])+[?]$", REG_EXTENDED);
    if (regex_compile_result) {
        (void)fprintf(stderr, "Could not compile regex\n");
        abort();
    }
    regex_compile_result = regexec(&re_comp, greeting, 0, NULL, 0);
    regfree(&re_comp);
    if (!regex_compile_result) {
        return "Calm down, I know what I'm doing!";
    }

    // All remaining questions.
    regex_compile_result =
        regcomp(&re_comp, "^.+[?][[:space:]]*$", REG_EXTENDED);
    if (regex_compile_result) {
        (void)fprintf(stderr, "Could not compile regex\n");
        abort();
    }
    regex_compile_result = regexec(&re_comp, greeting, 0, NULL, 0);
    regfree(&re_comp);
    if (!regex_compile_result) {
        return "Sure.";
    }

    // Generic statement.
    regex_compile_result = regcomp(
        &re_comp, "^([[:digit:]]|[[:punct:]|[[:space:]])+$", REG_EXTENDED);
    if (regex_compile_result) {
        (void)fprintf(stderr, "Could not compile regex\n");
        abort();
    }
    regex_compile_result = regexec(&re_comp, greeting, 0, NULL, 0);
    regfree(&re_comp);
    if (!regex_compile_result) {
        return "Whatever.";
    }

    // Yelling statement.
    regex_compile_result =
        regcomp(&re_comp, "^([[:upper:]]|[[:digit:]]|[[:punct:]|[[:space:]])+$",
                REG_EXTENDED);
    if (regex_compile_result) {
        (void)fprintf(stderr, "Could not compile regex\n");
        abort();
    }
    regex_compile_result = regexec(&re_comp, greeting, 0, NULL, 0);
    regfree(&re_comp);
    if (!regex_compile_result) {
        return "Whoa, chill out!";
    }

    return "Whatever.";
}
