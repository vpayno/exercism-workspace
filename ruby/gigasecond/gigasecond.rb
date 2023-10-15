# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/gigasecond
# Gigasecond exercise
class Gigasecond
  GIGASECOND = 1_000_000_000

  def self.from(time_stamp)
    time_stamp + GIGASECOND
  end
end
