# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/isbn-verifier
# ISBN Verifier exercise
module IsbnVerifier
  def self.valid?(input)
    return false if input !~ /^[0-9]-?[0-9]{3}-?[0-9]{5}-?[0-9X]$/

    digits = string2digits(input)

    pos = 11
    digits.map! { |rune| (pos -= 1) * rune }
    digits.sum.modulo(11).zero?
  end

  def self.string2digits(string)
    digits = string.chars.select { |rune| rune.match(/[0-9]|X/) }
    digits.map { |rune| rune.eql?('X') ? 10 : rune.to_i }
  end

  private_class_method :string2digits
end
