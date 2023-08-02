#if !defined(MEETUP_HPP)
#define MEETUP_HPP

#include <boost/date_time/gregorian/gregorian.hpp>

namespace meetup {

using func_name_t = std::string;

using date_t = boost::gregorian::date;

using day_t = boost::gregorian::greg_day;
using month_t = boost::gregorian::greg_month;
using year_t = boost::gregorian::greg_year;

using weekday_t = boost::date_time::weekdays;

using first_day_t = boost::gregorian::first_day_of_the_week_before;
using nth_day_t = boost::gregorian::nth_day_of_the_week_in_month;
using last_day_t = boost::gregorian::last_day_of_the_week_in_month;

struct scheduler final {
  public:
    scheduler(month_t month, year_t year);
    [[nodiscard]] date_t monteenth() const;
    [[nodiscard]] date_t tuesteenth() const;
    [[nodiscard]] date_t wednesteenth() const;
    [[nodiscard]] date_t thursteenth() const;
    [[nodiscard]] date_t friteenth() const;
    [[nodiscard]] date_t saturteenth() const;
    [[nodiscard]] date_t sunteenth() const;
    [[nodiscard]] date_t first_monday() const;
    [[nodiscard]] date_t first_tuesday() const;
    [[nodiscard]] date_t first_wednesday() const;
    [[nodiscard]] date_t first_thursday() const;
    [[nodiscard]] date_t first_friday() const;
    [[nodiscard]] date_t first_saturday() const;
    [[nodiscard]] date_t first_sunday() const;
    [[nodiscard]] date_t second_monday() const;
    [[nodiscard]] date_t second_tuesday() const;
    [[nodiscard]] date_t second_wednesday() const;
    [[nodiscard]] date_t second_thursday() const;
    [[nodiscard]] date_t second_friday() const;
    [[nodiscard]] date_t second_saturday() const;
    [[nodiscard]] date_t second_sunday() const;
    [[nodiscard]] date_t third_monday() const;
    [[nodiscard]] date_t third_tuesday() const;
    [[nodiscard]] date_t third_wednesday() const;
    [[nodiscard]] date_t third_thursday() const;
    [[nodiscard]] date_t third_friday() const;
    [[nodiscard]] date_t third_saturday() const;
    [[nodiscard]] date_t third_sunday() const;
    [[nodiscard]] date_t fourth_monday() const;
    [[nodiscard]] date_t fourth_tuesday() const;
    [[nodiscard]] date_t fourth_wednesday() const;
    [[nodiscard]] date_t fourth_thursday() const;
    [[nodiscard]] date_t fourth_friday() const;
    [[nodiscard]] date_t fourth_saturday() const;
    [[nodiscard]] date_t fourth_sunday() const;
    [[nodiscard]] date_t last_monday() const;
    [[nodiscard]] date_t last_tuesday() const;
    [[nodiscard]] date_t last_wednesday() const;
    [[nodiscard]] date_t last_thursday() const;
    [[nodiscard]] date_t last_friday() const;
    [[nodiscard]] date_t last_saturday() const;
    [[nodiscard]] date_t last_sunday() const;

  private:
    [[nodiscard]] date_t _dayteenth(weekday_t day) const;
    [[nodiscard]] date_t _first_weekday(weekday_t day) const;
    [[nodiscard]] date_t _second_weekday(weekday_t day) const;
    [[nodiscard]] date_t _third_weekday(weekday_t day) const;
    [[nodiscard]] date_t _fourth_weekday(weekday_t day) const;
    [[nodiscard]] date_t _last_weekday(weekday_t day) const;

    [[nodiscard]] static weekday_t
    _get_day_from_func_name(func_name_t func_name);

    month_t _month;
    year_t _year;
};

} // namespace meetup

#endif // MEETUP_HPP
