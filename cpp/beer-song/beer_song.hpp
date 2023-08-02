#if !defined(BEER_SONG_HPP)
#define BEER_SONG_HPP

#include <boost/format.hpp> // using this instead of std::format because we aren't using c++20
#include <sstream> // need this to save the output of boost::format
#include <string>

namespace beer_song {

std::string sing(int start, int stop = 0);
std::string verse(int beer_count);

} // namespace beer_song

#endif // BEER_SONG_HPP
