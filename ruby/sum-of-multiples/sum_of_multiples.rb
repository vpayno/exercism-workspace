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
      get_multiples item, base_value
    end

    @multiples.sum
  end

  def get_multiples(factor, limit)
    (1...limit).each do |multiple|
      @multiples.add(multiple) if multiple.modulo(factor).zero?
    end
  end

  private :get_multiples
end
