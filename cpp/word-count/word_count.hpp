#if !defined(WORD_COUNT_HPP)
#define WORD_COUNT_HPP

#include <map>
#include <string>

namespace word_count {

std::map<std::string, int> words(std::string text);

} // namespace word_count

#endif // WORD_COUNT_HPP
