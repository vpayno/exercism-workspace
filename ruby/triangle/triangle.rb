# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/triangle
# Triangle exercise
class Triangle
  def initialize(sides)
    @side_a = sides[0]
    @side_b = sides[1]
    @side_c = sides[2]
  end

  def triangle?
    return false if @side_a.zero? || @side_b.zero? || @side_c.zero?

    @side_a + @side_b > @side_c && @side_a + @side_c > @side_b && @side_b + @side_c > @side_a
  end

  def equilateral?
    triangle? && @side_a == @side_b && @side_a == @side_c
  end

  def isosceles?
    triangle? && (
      @side_a == @side_b ||
      @side_b == @side_c ||
      @side_a == @side_c
    )
  end

  def scalene?
    triangle? && @side_a != @side_b && @side_a != @side_c && @side_b != @side_c
  end
end
