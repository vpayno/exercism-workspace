# frozen_string_literal: false

require 'set'

# https://exercism.org/tracks/ruby/exercises/sum-of-multiples
# Sum of Multiples exercise
class SumOfMultiples
  def initialize(*args)
    @magical_items = args

    @multiples = Set[]
  end

  def to(base_value)
    return 0 if base_value.zero?

    @magical_items.each do |item|
      (1...base_value).each do |multiple|
        @multiples.add(multiple) if multiple.modulo(item).zero?
      end
    end

    @multiples.sum
  end
end
