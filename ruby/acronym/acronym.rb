# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/acronym
# Acronym exercise
module Acronym
  def self.abbreviate(input)
    text = input.chomp.upcase

    first = true
    runes = text.chars.select do |rune|
      if first && ('A'..'Z').include?(rune)
        first = false
        true
      elsif [' ', '_', '-'].include?(rune)
        first = true
        false
      else
        false
      end
    end

    runes.join('')
  end
end
