# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/armstrong-numbers
# Armstrong Numbers exercise
module ArmstrongNumbers
  def self.include?(candidate)
    digits = candidate.digits
    powers = digits.map { |digit| digit**digits.count }
    sum = powers.sum

    sum == candidate
  end
end
