# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/difference-of-squares
# Difference of Squares exercise
class Squares
  def initialize(number)
    @number = number
  end

  def square_of_sum
    (@number * (@number + 1) / 2)**2
  end

  def sum_of_squares
    @number * (@number + 1) * (2 * @number + 1) / 6
  end

  def difference
    square_of_sum - sum_of_squares
  end
end
