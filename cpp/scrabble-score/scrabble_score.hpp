#if !defined(SCRABBLE_SCORE_HPP)
#define SCRABBLE_SCORE_HPP

#include <string>

namespace scrabble_score {

using score_t = unsigned int;
using word_t = std::string;
using letter_t = char;

score_t score(word_t word);

} // namespace scrabble_score

#endif // SCRABBLE_SCORE_HPP
