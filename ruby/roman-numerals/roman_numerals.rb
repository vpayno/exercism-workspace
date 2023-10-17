# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/roman-numerals
# Roman Numerals exercise
class Integer
  D2R = {
    1 => 'I',
    4 => 'IV',
    5 => 'V',
    9 => 'IX',
    10 => 'X',
    40 => 'XL',
    50 => 'L',
    90 => 'XC',
    100 => 'C',
    400 => 'CD',
    500 => 'D',
    900 => 'CM',
    1_000 => 'M'
  }.to_a.reverse.to_h.freeze

  def to_roman
    number = clone
    buffer = ''

    D2R.each do |decimal, roman|
      while number >= decimal
        buffer = "#{buffer}#{roman}"
        number -= decimal
      end
    end

    buffer
  end
end
