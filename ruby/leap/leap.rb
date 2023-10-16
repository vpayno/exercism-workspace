# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/leap
# Leap exercise
module Year
  def self.leap?(year)
    return true if year.modulo(400).zero?
    return false if year.modulo(100).zero?
    return true if year.modulo(4).zero?

    false
  end
end
