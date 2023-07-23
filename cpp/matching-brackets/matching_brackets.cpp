#include "matching_brackets.hpp"

namespace matching_brackets {

bool check(std::string text) {
    std::stack<char> bracket_stack{};

    for (auto it = text.begin(); it < text.end(); it++) {
        const char rune = *it;

        if (!bracket_either(rune)) {
            continue;
        }

        if (bracket_open(rune)) {
            bracket_stack.push(rune);

            continue;
        }

        if (bracket_close(rune)) {
            if (bracket_stack.empty()) {
                return false;
            }

            if (!bracket_match(bracket_stack.top(), rune)) {
                return false;
            }

            bracket_stack.pop();
            continue;
        }
    }

    return bracket_stack.empty();
}

bool bracket_match(char open_bracket, char close_bracket) {
    if (open_bracket == '[' and close_bracket == ']') {
        return true;
    }

    if (open_bracket == '(' and close_bracket == ')') {
        return true;
    }

    if (open_bracket == '{' and close_bracket == '}') {
        return true;
    }

    return false;
}

bool bracket_open(char bracket) {
    return bracket == '[' or bracket == '(' or bracket == '{';
}

bool bracket_close(char bracket) {
    return bracket == ']' or bracket == ')' or bracket == '}';
}

bool bracket_either(char bracket) {
    return bracket_open(bracket) or bracket_close(bracket);
}
} // namespace matching_brackets
