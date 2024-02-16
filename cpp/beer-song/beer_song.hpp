#if !defined(BEER_SONG_HPP)
#define BEER_SONG_HPP

#include <string>

namespace beer_song {

std::string sing(int start, int stop = 0);
std::string verse(int beer_count);

} // namespace beer_song

#endif // BEER_SONG_HPP
