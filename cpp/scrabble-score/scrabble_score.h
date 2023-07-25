#if !defined(SCRABBLE_SCORE_H)
#define SCRABBLE_SCORE_H

#include <cctype>
#include <regex>
#include <string>

namespace scrabble_score {

unsigned int score(std::string word);

} // namespace scrabble_score

#endif // SCRABBLE_SCORE_H
