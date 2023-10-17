# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/luhn
# Luhn exercise
module Luhn
  def self.valid?(number)
    code = number.to_s.gsub(/\s+/, '').chomp
    digits = code.chars

    return false if digits.eql?(['0'])
    return false if digits.empty?
    return false unless digits.all?('0'..'9')

    steps(digits.map(&:to_i).reverse).modulo(10).zero?
  end

  def self.steps(digits)
    index = 1
    size = digits.length

    while index < size
      digits[index] *= 2

      digits[index] -= 9 if digits[index] > 9

      index += 2

      break if index >= size
    end

    digits.sum
  end
end
