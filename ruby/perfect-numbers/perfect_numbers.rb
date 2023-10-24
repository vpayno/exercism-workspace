# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/perfect-numbers
# Perfect Numbers exercise
module PerfectNumber
  Struct.new('Kind', :name, :value) do
    def to_s
      name
    end

    def to_i
      value
    end
  end

  DEFICIENT = Struct::Kind.new('deficient', -1)
  PERFECT = Struct::Kind.new('perfect', 0)
  ABUNDANT = Struct::Kind.new('abundant', 1)

  def self.classify(number)
    raise 'perfect numbers are postive' unless number.positive?

    factors = []

    (1...number).each do |factor|
      factors.push(factor) if number.modulo(factor).zero?
    end

    aliquot_sum = factors.sum

    if aliquot_sum > number
      ABUNDANT.to_s
    elsif aliquot_sum < number
      DEFICIENT.to_s
    else
      PERFECT.to_s
    end
  end
end
