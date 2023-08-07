#include "food_chain.h"

namespace food_chain {

std::string verse(unsigned int verse_number) {
    std::stringstream lyric{};

    if (verse_number == 0 or verse_number > k_verse_max) {
        return lyric.str();
    }

    // easier to work with 0-based offsets
    verse_number -= 1;

    lyric << k_animal_line1 << k_animals.at(verse_number) << "." << std::endl;
    lyric << k_animal_line2.at(verse_number);

    if (verse_number >= k_animal_line3.size()) {
        return lyric.str();
    }

    for (unsigned int i = verse_number; i > 0; i--) {
        lyric << "She swallowed the " << k_animals.at(i) << " to catch the "
              << k_animals.at(i - 1);
        lyric << k_animal_line3.at(i);
    }

    lyric << k_animal_line3.at(0);

    return lyric.str();
}

// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
std::string verses(unsigned int verse_start, unsigned int verse_end) {
    std::stringstream lyrics{};

    for (unsigned int i = verse_start; i <= verse_end; i++) {
        lyrics << verse(i) << std::endl;
    }

    return lyrics.str();
}

std::string sing() { return verses(k_verse_min, k_verse_max); }

} // namespace food_chain
