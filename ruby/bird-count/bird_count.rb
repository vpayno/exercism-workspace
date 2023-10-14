# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/bird-count
# Bird Count exercise
class BirdCount
  def self.last_week
    [0, 2, 5, 3, 7, 8, 4]
  end

  def initialize(birds_per_day)
    @this_week = birds_per_day
  end

  def yesterday
    @this_week[-2]
  end

  def total
    @this_week.sum
  end

  def busy_days
    @this_week.reduce(0) do |sum, item|
      next sum += 1 if item >= 5

      sum
    end
  end

  def day_without_birds?
    @this_week.each { |number| return true if number.zero? }

    false
  end
end
