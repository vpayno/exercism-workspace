#include "gigasecond.h"

namespace gigasecond {

boost::posix_time::ptime advance(const boost::posix_time::ptime &date) {
    const boost::posix_time::seconds GIGASECOND{1'000'000'000};

    return date + boost::posix_time::seconds(GIGASECOND);
}

} // namespace gigasecond
