# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/grains
# Grains exercise
module Grains
  INDEX_MIN = 1
  INDEX_MAX = 64

  def self.valid_index?(index)
    (INDEX_MIN..INDEX_MAX).include?(index)
  end

  def self.square(index)
    raise ArgumentError, 'index must be between 1 and 64' unless valid_index?(index)

    1 << (index - 1)
  end

  def self.total
    # (1 << 64) - 1
    # ((1 << 63) << 1) - 1
    ((1..64).map { |index| square(index) }).sum
  end
end
