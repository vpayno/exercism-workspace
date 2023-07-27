#if !defined(ANAGRAM_HPP)
#define ANAGRAM_HPP

#include <algorithm>
#include <string>
#include <utility>
#include <vector>

namespace anagram {

class anagram {
  public:
    anagram(std::string subject) : target{std::move(subject)} {
        std::transform(target.begin(), target.end(),
                       std::back_inserter(target_lower), tolower);
        std::transform(target.begin(), target.end(),
                       std::back_inserter(target_sorted), tolower);
        std::sort(target_sorted.begin(), target_sorted.end());
    }
    std::vector<std::string> matches(std::vector<std::string> words);

  private:
    std::string target{};
    std::string target_lower{};
    std::string target_sorted{};
};

} // namespace anagram

#endif // ANAGRAM_HPP
