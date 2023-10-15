# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/raindrops
# Raindrops exercise
class Raindrops
  def self.convert(number)
    number.to_sounds
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

  # using the argument as a way to initialize the variable without an extra statement and
  # it lets you append to an existing string
  def to_sounds(result = '')
    result = "#{result}Pling" if pling?
    result = "#{result}Plang" if plang?
    result = "#{result}Plong" if plong?

    result = to_s if result.empty?

    result
  end
end
