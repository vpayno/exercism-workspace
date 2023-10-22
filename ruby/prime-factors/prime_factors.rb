# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/prime-factors
# Prime Factors exercise
module PrimeFactors
  def self.of(number)
    factors = []

    case number
    when 0 | 1
      return factors
    when 2
      factors.push(2)
      return factors
    end

    if number > 5
      primes = sieve(MAX_PRIMES)
      primes.select! { |prime| prime < (number / 2) + 1 }
    else
      primes = sieve(5)
    end

    factors = []
    factor = primes.pop
    while number > 1
      while number.modulo(factor).zero? && number > 1
        number /= factor
        factors.push(factor)
      end

      factor = primes.pop
    end

    factors.sort
  end

  MAX_PRIMES = 1_000_000

  def self.sieve(limit)
    result = []
    return result if limit < 2

    result.push(2)
    return result if limit == 2

    @numbers = Array.new(limit + 1, true)
    @numbers.each_index { |number| @numbers[number] = false if number.modulo(2).zero? }
    @numbers[0] = @numbers[1] = false
    @numbers[2] = true

    (3..limit).step(2).each_entry do |number|
      is_prime = @numbers[number]
      next unless is_prime

      jdex = 3
      while (mul = number * jdex) <= limit
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
