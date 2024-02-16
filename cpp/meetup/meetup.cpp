#include "meetup.hpp"
#include <boost/current_function.hpp>
#include <boost/date_time/gregorian/greg_date.hpp>
#include <boost/date_time/gregorian/greg_weekday.hpp>
#include <string>

// this would be a perfect exercise to practice with Rust macros

namespace meetup {

scheduler::scheduler(month_t month, year_t year) : _month(month), _year(year) {}

date_t scheduler::_dayteenth(weekday_t day) const {
    const first_day_t object(day);
    const date_t date =
        object.get_date(boost::gregorian::date(_year, _month, 20));

    return date;
}

date_t scheduler::_first_weekday(weekday_t day) const {
    const nth_day_t object(nth_day_t::first, day, _month);
    const date_t date = object.get_date(_year);

    return date;
}

date_t scheduler::_second_weekday(weekday_t day) const {
    const nth_day_t object(nth_day_t::second, day, _month);
    const date_t date = object.get_date(_year);

    return date;
}

date_t scheduler::_third_weekday(weekday_t day) const {
    const nth_day_t object(nth_day_t::third, day, _month);
    const date_t date = object.get_date(_year);

    return date;
}

date_t scheduler::_fourth_weekday(weekday_t day) const {
    const nth_day_t object(nth_day_t::fourth, day, _month);
    const date_t date = object.get_date(_year);

    return date;
}

date_t scheduler::_last_weekday(weekday_t day) const {
    const last_day_t object(day, _month);
    const date_t date = object.get_date(_year);

    return date;
}

// _dayteenth() methods

weekday_t scheduler::_get_day_from_func_name(func_name_t func_name) {
    /* https://www.techiedelight.com/find-name-of-the-calling-function-in-cpp/
     *  not sure why I didn't need to `#include <boost/current_function.hpp>`
     *
     *  Use `const weekday_t weekday =
     * _get_day_from_func_name(BOOST_CURRENT_FUNCTION);` to get the week day in
     * the public methods.
     */

    weekday_t day{};

    // https://cplusplus.com/reference/string/string/find/
    if (func_name.find("mon") != std::string::npos) {
        day = boost::gregorian::Monday;
    } else if (func_name.find("tues") != std::string::npos) {
        day = boost::gregorian::Tuesday;
    } else if (func_name.find("wednes") != std::string::npos) {
        day = boost::gregorian::Wednesday;
    } else if (func_name.find("thurs") != std::string::npos) {
        day = boost::gregorian::Thursday;
    } else if (func_name.find("fri") != std::string::npos) {
        day = boost::gregorian::Friday;
    } else if (func_name.find("satur") != std::string::npos) {
        day = boost::gregorian::Saturday;
    } else {
        day = boost::gregorian::Sunday;
    }

    return day;
}

date_t scheduler::monteenth() const {
    const weekday_t weekday = _get_day_from_func_name(BOOST_CURRENT_FUNCTION);

    return _dayteenth(weekday);
}

date_t scheduler::tuesteenth() const {
    return _dayteenth(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::wednesteenth() const {
    return _dayteenth(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::thursteenth() const {
    return _dayteenth(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::friteenth() const {
    return _dayteenth(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::saturteenth() const {
    return _dayteenth(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::sunteenth() const {
    return _dayteenth(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

// _first_weekday() methonds

date_t scheduler::first_monday() const {
    const weekday_t weekday = _get_day_from_func_name(BOOST_CURRENT_FUNCTION);

    return _first_weekday(weekday);
}

date_t scheduler::first_tuesday() const {
    return _first_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::first_wednesday() const {
    return _first_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::first_thursday() const {
    return _first_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::first_friday() const {
    return _first_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::first_saturday() const {
    return _first_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::first_sunday() const {
    return _first_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

// _second_weekday() methods

date_t scheduler::second_monday() const {
    const weekday_t weekday = _get_day_from_func_name(BOOST_CURRENT_FUNCTION);

    return _second_weekday(weekday);
}

date_t scheduler::second_tuesday() const {
    return _second_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::second_wednesday() const {
    return _second_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::second_thursday() const {
    return _second_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::second_friday() const {
    return _second_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::second_saturday() const {
    return _second_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::second_sunday() const {
    return _second_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

// _third_weekday() methods

date_t scheduler::third_monday() const {
    const weekday_t weekday = _get_day_from_func_name(BOOST_CURRENT_FUNCTION);

    return _third_weekday(weekday);
}

date_t scheduler::third_tuesday() const {
    return _third_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::third_wednesday() const {
    return _third_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::third_thursday() const {
    return _third_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::third_friday() const {
    return _third_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::third_saturday() const {
    return _third_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::third_sunday() const {
    return _third_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

// _fourth_weekday() methods

date_t scheduler::fourth_monday() const {
    const weekday_t weekday = _get_day_from_func_name(BOOST_CURRENT_FUNCTION);

    return _fourth_weekday(weekday);
}

date_t scheduler::fourth_tuesday() const {
    return _fourth_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::fourth_wednesday() const {
    return _fourth_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::fourth_thursday() const {
    return _fourth_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::fourth_friday() const {
    return _fourth_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::fourth_saturday() const {
    return _fourth_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::fourth_sunday() const {
    return _fourth_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

// _last_weekday() methods

date_t scheduler::last_monday() const {
    const weekday_t weekday = _get_day_from_func_name(BOOST_CURRENT_FUNCTION);

    return _last_weekday(weekday);
}

date_t scheduler::last_tuesday() const {
    return _last_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::last_wednesday() const {
    return _last_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::last_thursday() const {
    return _last_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::last_friday() const {
    return _last_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::last_saturday() const {
    return _last_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

date_t scheduler::last_sunday() const {
    return _last_weekday(_get_day_from_func_name(BOOST_CURRENT_FUNCTION));
}

} // namespace meetup
