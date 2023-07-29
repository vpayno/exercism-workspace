#if !defined(WORD_COUNT_H)
#define WORD_COUNT_H

#include <algorithm>
#include <map>
#include <regex>
#include <string>

namespace word_count {

std::map<std::string, int> words(std::string text);

} // namespace word_count

#endif // WORD_COUNT_H
