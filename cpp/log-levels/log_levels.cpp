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

    // 1st iteration, using + operator
    return msg + " (" + level + ")";
}

} // namespace log_line
