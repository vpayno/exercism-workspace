#include "beer_song.h"

namespace beer_song {

// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
std::string sing(int start, int stop) {
    std::stringstream verses;

    if (start < stop) {
        verses << boost::format("starting verse, %1%, needs to be greater than "
                                "or equal to the ending verse, %2%") %
                      start % stop;

        return verses.str();
    }

    for (int i = start; i >= stop; i--) {
        verses << verse(i);

        if (i != stop) {
            verses << "\n";
        }
    }

    return verses.str();
}

std::string verse(int beer_count) {
    const std::string fs1{
        "%1% bottle%2% of beer on the wall, %1% bottle%2% of beer.\n"};
    const std::string fs2{"Take %3% down and pass it around, %1% bottle%2% of "
                          "beer on the wall.\n"};

    std::string count_word{"one"};
    std::string plural{};

    if (beer_count < 0) {
        return "you can't have a negative amount of beer bottles";
    }

    if (beer_count > 99) {
        return "you can't have more than 99 beer bottles";
    }

    if (beer_count == 0) {
        const std::string line1 =
            "No more bottles of beer on the wall, no more bottles of beer.\n";
        const std::string line2 = "Go to the store and buy some more, 99 "
                                  "bottles of beer on the wall.\n";

        return line1 + line2;
    }

    if (beer_count > 1) {
        plural = "s";
    }

    std::stringstream line1;
    std::stringstream line2;

    line1 << boost::format(fs1) % beer_count % plural;

    beer_count -= 1;

    if (beer_count == 0 or beer_count > 1) {
        plural = "s";
    } else {
        plural = "";
    }

    std::stringstream beer_word;

    if (beer_count == 0) {
        beer_word << "no more";
        count_word = "it";
        plural = "s";
    } else {
        beer_word << boost::format("%1%") % beer_count;
    }

    line2 << boost::format(fs2) % beer_word.str() % plural % count_word;
    return line1.str() + line2.str();
}

} // namespace beer_song
