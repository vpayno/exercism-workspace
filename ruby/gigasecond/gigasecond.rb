# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/gigasecond
# Gigasecond exercise
class Gigasecond
  GIGASECOND = 10**9

  def self.from(time_stamp)
    time_stamp + GIGASECOND
  end
end
