# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/isogram
# Isogram exercise
module Isogram
  def self.isogram?(input)
    word = input.gsub(/(\s+|-)/, '').downcase

    return true if word.empty?
    return false unless word.match(/^[a-z]+$/)

    isogram = word.chars.uniq.join('')

    word.eql?(isogram)
  end
end
