#include "space_age.hpp"

namespace space_age {

space_age::space_age(seconds_t seconds) : age_in_seconds{seconds} {}

seconds_t space_age::seconds() const { return age_in_seconds; }

seconds_t space_age::on_planet(planet_name_t name) const {
    return seconds() / (planets.at(name) * seconds_in_earth_year);
}

seconds_t space_age::on_mercury() const { return on_planet("mercury"); }

seconds_t space_age::on_venus() const { return on_planet("venus"); }

seconds_t space_age::on_earth() const { return on_planet("earth"); }

seconds_t space_age::on_mars() const { return on_planet("mars"); }

seconds_t space_age::on_jupiter() const { return on_planet("jupiter"); }

seconds_t space_age::on_saturn() const { return on_planet("saturn"); }

seconds_t space_age::on_uranus() const { return on_planet("uranus"); }

seconds_t space_age::on_neptune() const { return on_planet("neptune"); }

} // namespace space_age
