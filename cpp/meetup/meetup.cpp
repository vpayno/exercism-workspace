#include "meetup.h"

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

date_t scheduler::monteenth() const {
    return _dayteenth(boost::gregorian::Monday);
}

date_t scheduler::tuesteenth() const {
    return _dayteenth(boost::gregorian::Tuesday);
}

date_t scheduler::wednesteenth() const {
    return _dayteenth(boost::gregorian::Wednesday);
}

date_t scheduler::thursteenth() const {
    return _dayteenth(boost::gregorian::Thursday);
}

date_t scheduler::friteenth() const {
    return _dayteenth(boost::gregorian::Friday);
}

date_t scheduler::saturteenth() const {
    return _dayteenth(boost::gregorian::Saturday);
}

date_t scheduler::sunteenth() const {
    return _dayteenth(boost::gregorian::Sunday);
}

// _first_weekday() methonds

date_t scheduler::first_monday() const {
    return _first_weekday(boost::gregorian::Monday);
}

date_t scheduler::first_tuesday() const {
    return _first_weekday(boost::gregorian::Tuesday);
}

date_t scheduler::first_wednesday() const {
    return _first_weekday(boost::gregorian::Wednesday);
}

date_t scheduler::first_thursday() const {
    return _first_weekday(boost::gregorian::Thursday);
}

date_t scheduler::first_friday() const {
    return _first_weekday(boost::gregorian::Friday);
}

date_t scheduler::first_saturday() const {
    return _first_weekday(boost::gregorian::Saturday);
}

date_t scheduler::first_sunday() const {
    return _first_weekday(boost::gregorian::Sunday);
}

// _second_weekday() methods

date_t scheduler::second_monday() const {
    return _second_weekday(boost::gregorian::Monday);
}

date_t scheduler::second_tuesday() const {
    return _second_weekday(boost::gregorian::Tuesday);
}

date_t scheduler::second_wednesday() const {
    return _second_weekday(boost::gregorian::Wednesday);
}

date_t scheduler::second_thursday() const {
    return _second_weekday(boost::gregorian::Thursday);
}

date_t scheduler::second_friday() const {
    return _second_weekday(boost::gregorian::Friday);
}

date_t scheduler::second_saturday() const {
    return _second_weekday(boost::gregorian::Saturday);
}

date_t scheduler::second_sunday() const {
    return _second_weekday(boost::gregorian::Sunday);
}

// _third_weekday() methods

date_t scheduler::third_monday() const {
    return _third_weekday(boost::gregorian::Monday);
}

date_t scheduler::third_tuesday() const {
    return _third_weekday(boost::gregorian::Tuesday);
}

date_t scheduler::third_wednesday() const {
    return _third_weekday(boost::gregorian::Wednesday);
}

date_t scheduler::third_thursday() const {
    return _third_weekday(boost::gregorian::Thursday);
}

date_t scheduler::third_friday() const {
    return _third_weekday(boost::gregorian::Friday);
}

date_t scheduler::third_saturday() const {
    return _third_weekday(boost::gregorian::Saturday);
}

date_t scheduler::third_sunday() const {
    return _third_weekday(boost::gregorian::Sunday);
}

// _fourth_weekday() methods

date_t scheduler::fourth_monday() const {
    return _fourth_weekday(boost::gregorian::Monday);
}

date_t scheduler::fourth_tuesday() const {
    return _fourth_weekday(boost::gregorian::Tuesday);
}

date_t scheduler::fourth_wednesday() const {
    return _fourth_weekday(boost::gregorian::Wednesday);
}

date_t scheduler::fourth_thursday() const {
    return _fourth_weekday(boost::gregorian::Thursday);
}

date_t scheduler::fourth_friday() const {
    return _fourth_weekday(boost::gregorian::Friday);
}

date_t scheduler::fourth_saturday() const {
    return _fourth_weekday(boost::gregorian::Saturday);
}

date_t scheduler::fourth_sunday() const {
    return _fourth_weekday(boost::gregorian::Sunday);
}

// _last_weekday() methods

date_t scheduler::last_monday() const {
    return _last_weekday(boost::gregorian::Monday);
}

date_t scheduler::last_tuesday() const {
    return _last_weekday(boost::gregorian::Tuesday);
}

date_t scheduler::last_wednesday() const {
    return _last_weekday(boost::gregorian::Wednesday);
}

date_t scheduler::last_thursday() const {
    return _last_weekday(boost::gregorian::Thursday);
}

date_t scheduler::last_friday() const {
    return _last_weekday(boost::gregorian::Friday);
}

date_t scheduler::last_saturday() const {
    return _last_weekday(boost::gregorian::Saturday);
}

date_t scheduler::last_sunday() const {
    return _last_weekday(boost::gregorian::Sunday);
}

} // namespace meetup
