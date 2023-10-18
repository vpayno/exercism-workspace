# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/darts
# Darts exercise
class Darts
  def initialize(point_x, point_y)
    @point_x = point_x
    @point_y = point_y

    @distance = Math.hypot(@point_x, @point_y)
  end

  def score
    return 10 if @distance <= 1.0
    return 5 if @distance <= 5.0
    return 1 if @distance <= 10.0

    0
  end
end
