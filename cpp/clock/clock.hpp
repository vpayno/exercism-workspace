#include <string>
#if !defined(CLOCK_HPP)
#define CLOCK_HPP

namespace date_independent {

using minutes_t = int;
using hours_t = int;

const hours_t k_hours_per_day = 24;
const minutes_t k_minutes_per_hour = 60;
const minutes_t k_minutes_per_day = k_hours_per_day * k_minutes_per_hour;

struct clock {
  public:
    static clock at(hours_t hours, minutes_t minutes);
    [[nodiscard]] minutes_t get_minutes() const;
    [[nodiscard]] clock plus(minutes_t minutes) const;
    operator std::string() const;
    bool operator==(clock other) const;
    bool operator!=(clock other) const;

  private:
    hours_t _hours{};
    minutes_t _minutes{};
    clock(minutes_t minutes);
    void normalize(hours_t hours, minutes_t minutes);
};

} // namespace date_independent

#endif // CLOCK_HPP
