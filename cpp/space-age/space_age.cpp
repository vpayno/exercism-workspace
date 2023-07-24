#include "space_age.h"

namespace space_age {

space_age::space_age(double seconds) : age_in_seconds{seconds} {}

double space_age::seconds() const { return age_in_seconds; }

double space_age::on_planet(std::string name) const {
    return seconds() / (planets.at(name) * seconds_in_earth_year);
}

double space_age::on_mercury() const { return on_planet("mercury"); }

double space_age::on_venus() const { return on_planet("venus"); }

double space_age::on_earth() const { return on_planet("earth"); }

double space_age::on_mars() const { return on_planet("mars"); }

double space_age::on_jupiter() const { return on_planet("jupiter"); }

double space_age::on_saturn() const { return on_planet("saturn"); }

double space_age::on_uranus() const { return on_planet("uranus"); }

double space_age::on_neptune() const { return on_planet("neptune"); }

} // namespace space_age
