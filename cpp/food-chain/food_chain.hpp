#if !defined(FOOD_CHAIN_HPP)
#define FOOD_CHAIN_HPP

#include <string>
#include <vector>

namespace food_chain {

const unsigned int k_verse_min = 1;
const unsigned int k_verse_max = 8;

const std::vector<std::string> k_animals = {
    "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse",
};

const std::string k_animal_line1 = "I know an old lady who swallowed a ";

const std::vector<std::string> k_animal_line2 = {
    "",
    "It wriggled and jiggled and tickled inside her.\n",
    "How absurd to swallow a bird!\n",
    "Imagine that, to swallow a cat!\n",
    "What a hog, to swallow a dog!\n",
    "Just opened her throat and swallowed a goat!\n",
    "I don't know how she swallowed a cow!\n",
    "She's dead, of course!\n"};

const std::vector<std::string> k_animal_line3 = {
    "I don't know why she swallowed the fly. Perhaps she'll die.\n",
    ".\n",
    " that wriggled and jiggled and tickled inside her.\n",
    ".\n",
    ".\n",
    ".\n",
    ".\n"};

std::string verse(unsigned int verse_number);
std::string verses(unsigned int verse_start, unsigned int verse_end);
std::string sing();

} // namespace food_chain

#endif // FOOD_CHAIN_HPP
