#if !defined(SCRABBLE_SCORE_HPP)
#define SCRABBLE_SCORE_HPP

#include <cctype>
#include <regex>
#include <string>

namespace scrabble_score {

unsigned int score(std::string word);

} // namespace scrabble_score

#endif // SCRABBLE_SCORE_HPP
