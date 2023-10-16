# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/armstrong-numbers
# Armstrong Numbers exercise
module ArmstrongNumbers
  def self.include?(candidate)
    return true if candidate < 10

    digit_count = (Math.log10(candidate) + 1).to_i

    num = candidate
    pow_total = 0

    while num.positive?
      pow_temp = num.modulo(10)
      pow_temp_total = 1

      (0...digit_count).each do
        pow_temp_total *= pow_temp
      end

      pow_total += pow_temp_total
      num /= 10
    end

    pow_total == candidate
  end
end
