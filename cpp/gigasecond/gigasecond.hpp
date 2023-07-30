#if !defined(GIGASECOND_HPP)
#define GIGASECOND_HPP

#include "boost/date_time/posix_time/posix_time.hpp"

namespace gigasecond {

using time = boost::posix_time::ptime;
using seconds = boost::posix_time::seconds;

time advance(const time &date);

} // namespace gigasecond

#endif // GIGASECOND_HPP
