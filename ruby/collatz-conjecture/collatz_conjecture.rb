# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/collatz-conjecture
# Collatz Conjecture exercise
module CollatzConjecture
  def self.steps(start)
    raise ArgumentError, "starting number can't be negative" if start < 1

    0 if start == 1

    num = start
    count = 0

    while num > 1
      count += 1

      if num.modulo(2).zero?
        num /= 2
      else
        num = num * 3 + 1
      end
    end

    count
  end
end
