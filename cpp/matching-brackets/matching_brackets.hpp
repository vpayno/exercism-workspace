#if !defined(MATCHING_BRACKETS_HPP)
#define MATCHING_BRACKETS_HPP

#include <stack>
#include <string>

namespace matching_brackets {

bool check(std::string text);

bool bracket_match(char open_bracket, char close_bracket);

bool bracket_open(char bracket);

bool bracket_close(char bracket);

bool bracket_either(char bracket);

} // namespace matching_brackets

#endif // MATCHING_BRACKETS_HPP
