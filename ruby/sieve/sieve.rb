# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/sieve
# Sieve exercise
class Sieve
  def initialize(limit)
    @limit = limit
  end

  def primes
    result = []
    return result if @limit < 2

    result.push(2)
    return result if @limit == 2

    @numbers = Array.new(@limit + 1, true)
    @numbers.each_index { |number| @numbers[number] = false if number.modulo(2).zero? }
    @numbers[0] = @numbers[1] = false
    @numbers[2] = true

    (3..@limit).step(2).each_entry do |number|
      is_prime = @numbers[number]
      next unless is_prime

      jdex = 3
      while (mul = number * jdex) <= @limit
        index = mul
        @numbers[index] = false
        jdex += 1
      end
    end

    result = []
    @numbers.each_with_index do |is_prime, index|
      result.push(index) if is_prime
    end

    result
  end
end
