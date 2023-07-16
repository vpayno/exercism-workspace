#include <cstdio>
#include <string>

namespace log_line {

std::string message(const std::string log_line) {
    // seems easiest to just find the first space and add 1 to it's index
    const size_t start = log_line.find(" ") + 1;

    return log_line.substr(start);
}

std::string log_level(const std::string log_line) {
    // get the start and end of the log level tokens
    const size_t start = log_line.find("[") + 1;
    // I want the ] after the first [.
    const size_t end = start + log_line.substr(start).find("]") - 1;

    return log_line.substr(start, end);
}

std::string reformat(const std::string log_line) {
    const std::string msg = message(log_line);
    const std::string level = log_level(log_line);

    // error: ISO C++ forbids variable length array ‘buffer’ [-Werror=vla]
    // const size_t size = msg.size() + level.size() + sizeof(" ()") + 1;
    const size_t size = 255;

    char buffer[size];

    sprintf(buffer, "%s (%s)", msg.c_str(), level.c_str());

    std::string new_log_line = "";

    // use the = operator to convert the char[] to string
    new_log_line = buffer;

    // 2nd iteration, using sprintf()
    // if we were using C++ >=20, we should be using format instead
    return new_log_line;
}

} // namespace log_line
