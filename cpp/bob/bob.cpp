#include "bob.h"
#include <regex>

namespace bob {

std::string hey(std::string greeting) {

    // Silence.
    const std::regex re_silence("^[[:space:]]*$", std::regex_constants::egrep);
    if (std::regex_search(greeting, re_silence)) {
        return "Fine. Be that way!";
    }

    // Question with only spaces and punctuation.
    const std::regex re_question_garbage("^([[:punct:]|[[:space:]])+[?]$",
                                         std::regex_constants::egrep);
    if (std::regex_search(greeting, re_question_garbage)) {
        return "Sure.";
    }

    // Question with uppercase letters, punctuation and spaces.
    const std::regex re_question_yelling(
        "^([[:upper:]]|[[:punct:]|[[:space:]])+[?]$",
        std::regex_constants::egrep);
    if (std::regex_search(greeting, re_question_yelling)) {
        return "Calm down, I know what I'm doing!";
    }

    // All remaining questions.
    const std::regex re_questions_etc("^.+[?][[:space:]]*$",
                                      std::regex_constants::egrep);
    if (std::regex_search(greeting, re_questions_etc)) {
        return "Sure.";
    }

    // Generic statement.
    const std::regex re_generic_statement(
        "^([[:digit:]]|[[:punct:]|[[:space:]])+$", std::regex_constants::egrep);
    if (std::regex_search(greeting, re_generic_statement)) {
        return "Whatever.";
    }

    // Yelling statement.
    const std::regex re_yelling_statement(
        "^([[:upper:]]|[[:digit:]]|[[:punct:]|[[:space:]])+$",
        std::regex_constants::egrep);
    if (std::regex_search(greeting, re_yelling_statement)) {
        return "Whoa, chill out!";
    }

    return "Whatever.";
}

} // namespace bob
