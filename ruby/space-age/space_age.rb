# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/space-age
# Space Age exercise
class SpaceAge
  SECONDS_IN_EARTH_YEAR = 365.25 * 24.0 * 60.0 * 60.0

  ORBITAL_PERIODS = {
    'mercury' => 0.2408467,
    'venus' => 0.61519726,
    'earth' => 1.0,
    'mars' => 1.8808158,
    'jupiter' => 11.862615,
    'saturn' => 29.447498,
    'uranus' => 84.016846,
    'neptune' => 164.79132
  }.freeze

  def initialize(age_in_seconds)
    @age_in_seconds = age_in_seconds
  end

  def on_planet(planet)
    @age_in_seconds / SECONDS_IN_EARTH_YEAR / ORBITAL_PERIODS[planet]
  end

  ORBITAL_PERIODS.each_key do |planet|
    define_method("on_#{planet}") do
      on_planet(planet)
    end
  end

  private :on_planet
end
