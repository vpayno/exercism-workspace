#include "gigasecond.hpp"

namespace gigasecond {

time advance(const time &date) {
    const seconds GIGASECOND{1'000'000'000};

    return date + seconds(GIGASECOND);
}

} // namespace gigasecond
