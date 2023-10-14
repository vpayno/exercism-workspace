# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/assembly-line
# AssemblyLine exercise
class AssemblyLine
  CARS_PER_HOUR = 221

  attr_reader :speed

  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    if @speed.between?(0, 4)
      success = 1.0
    elsif @speed.between?(5, 8)
      success = 0.90
    elsif @speed == 9
      success = 0.80
    elsif @speed == 10
      success = 0.77
    else
      raise 'Speed must be between 0 and 10'
    end

    @speed * success * CARS_PER_HOUR
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
