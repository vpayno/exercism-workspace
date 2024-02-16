#include "word_count.hpp"

#include <algorithm>
#include <cctype>
#include <iterator>
#include <map>
#include <regex>
#include <string>

namespace word_count {

std::map<std::string, int> words(std::string text) {
    std::transform(text.begin(), text.end(), text.begin(), tolower);

    auto word_only_op = [](char rune) {
        return (bool)isalnum(rune) or rune == '\'';
    };

    std::map<std::string, int> counter{};

    const std::regex re_delim(
        R"re_str((,|[[:punct:]]*\s+[[:punct:]]*|[[:punct:]]$))re_str");

    std::sregex_token_iterator re_it(text.begin(), text.end(), re_delim, -1);
    auto iter_end = std::sregex_token_iterator();

    for (; re_it != iter_end; re_it++) {
        std::string sequence = *re_it;
        std::string word{};

        std::copy_if(sequence.begin(), sequence.end(), std::back_inserter(word),
                     word_only_op);

        if (word.empty()) {
            continue;
        }

        counter[word] += 1;
    }

    return counter;
}

} // namespace word_count
