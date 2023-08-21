#if !defined(SPACE_AGE_HPP)
#define SPACE_AGE_HPP

#include <map>
#include <string>

namespace space_age {

using seconds_t = double;
using planet_name_t = std::string;

class space_age {
  public:
    space_age(seconds_t seconds);

    [[nodiscard]] seconds_t seconds() const;
    [[nodiscard]] seconds_t on_earth() const;
    [[nodiscard]] seconds_t on_mercury() const;
    [[nodiscard]] seconds_t on_venus() const;
    [[nodiscard]] seconds_t on_mars() const;
    [[nodiscard]] seconds_t on_jupiter() const;
    [[nodiscard]] seconds_t on_saturn() const;
    [[nodiscard]] seconds_t on_uranus() const;
    [[nodiscard]] seconds_t on_neptune() const;

  private:
    seconds_t age_in_seconds{0};
    seconds_t seconds_in_earth_year{365.25 * 24 * 60 * 60};

    std::map<planet_name_t, seconds_t> planets{
        {"mercury", 0.2408467}, {"venus", 0.61519726},  {"earth", 1.0},
        {"mars", 1.8808158},    {"jupiter", 11.862615}, {"saturn", 29.447498},
        {"uranus", 84.016846},  {"neptune", 164.79132},
    };

    [[nodiscard]] seconds_t on_planet(planet_name_t name) const;
};

} // namespace space_age

#endif // SPACE_AGE_HPP
