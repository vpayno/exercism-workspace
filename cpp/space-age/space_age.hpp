#if !defined(SPACE_AGE_HPP)
#define SPACE_AGE_HPP

#include <map>
#include <string>

namespace space_age {

class space_age {
  public:
    space_age(double seconds);

    [[nodiscard]] double seconds() const;
    [[nodiscard]] double on_earth() const;
    [[nodiscard]] double on_mercury() const;
    [[nodiscard]] double on_venus() const;
    [[nodiscard]] double on_mars() const;
    [[nodiscard]] double on_jupiter() const;
    [[nodiscard]] double on_saturn() const;
    [[nodiscard]] double on_uranus() const;
    [[nodiscard]] double on_neptune() const;

  private:
    double age_in_seconds{0};
    double seconds_in_earth_year{365.25 * 24 * 60 * 60};

    std::map<std::string, double> planets{
        {"mercury", 0.2408467}, {"venus", 0.61519726F}, {"earth", 1.0},
        {"mars", 1.8808158},    {"jupiter", 11.862615}, {"saturn", 29.447498},
        {"uranus", 84.016846},  {"neptune", 164.79132},
    };

    [[nodiscard]] double on_planet(std::string name) const;
};

} // namespace space_age

#endif // SPACE_AGE_HPP
