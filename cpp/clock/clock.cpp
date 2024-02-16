#include "clock.hpp"
#include <boost/format/format_fwd.hpp>
#include <string>

namespace date_independent {

void clock::normalize(hours_t hours, minutes_t minutes) {
    while (minutes < 0) {
        minutes += k_minutes_per_hour;
        hours -= 1;
    }

    while (hours < 0) {
        hours += k_hours_per_day;
    }

    const minutes_t tmp_min = hours * k_minutes_per_hour + minutes;

    if (tmp_min > k_minutes_per_hour) {
        hours = (tmp_min / k_minutes_per_hour) % k_hours_per_day;
        minutes = tmp_min % k_minutes_per_hour;
    }

    _hours = hours;
    _minutes = minutes;
}

clock::clock(minutes_t minutes) { normalize(0, minutes); }

clock clock::at(hours_t hours, minutes_t minutes) {
    return {((hours % k_minutes_per_day) * k_minutes_per_hour) +
            (minutes % k_minutes_per_day)};
}

clock clock::plus(minutes_t minutes) const { return {get_minutes() + minutes}; }

minutes_t clock::get_minutes() const {
    return (_hours * k_minutes_per_hour) + _minutes;
}

clock::operator std::string() const {
    return (boost::format("%|1$02|:%|2$02|") % _hours % _minutes).str();
}

bool clock::operator==(const clock other) const {
    return get_minutes() == other.get_minutes();
}

bool clock::operator!=(const clock other) const {
    return get_minutes() != other.get_minutes();
}

} // namespace date_independent
