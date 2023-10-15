# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/raindrops
# Raindrops exercise
class Raindrops
  def self.convert(number)
    sounds = ''

    sounds = "#{sounds}Pling" if number.pling?
    sounds = "#{sounds}Plang" if number.plang?
    sounds = "#{sounds}Plong" if number.plong?

    sounds = number.to_s if sounds.empty?

    sounds
  end
end

# Adding sound methods to integers.
class Integer
  def pling?
    (self % 3).zero?
  end

  def plang?
    (self % 5).zero?
  end

  def plong?
    (self % 7).zero?
  end
end
