#include "space_age.h"

const float seconds_in_earth_year = 365.25F * 24 * 60 * 60;

bool is_planet(planet_t planet) {
    if (planet >= MERCURY && planet < PLANET_COUNT) {
        return true;
    }

    return false;
}

float age(planet_t planet, int64_t seconds) {
    if (!is_planet(planet)) {
        return -1.0F;
    }

    float planets[PLANET_COUNT] = {0.0F};

    planets[MERCURY] = 0.2408467F;
    planets[VENUS] = 0.61519726F;
    planets[EARTH] = 1.0F;
    planets[MARS] = 1.8808158F;
    planets[JUPITER] = 11.862615F;
    planets[SATURN] = 29.447498F;
    planets[URANUS] = 84.016846F;
    planets[NEPTUNE] = 164.79132F;

    return (float)seconds / (planets[planet] * seconds_in_earth_year);
}
