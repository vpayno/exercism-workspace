# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/pangram
# Pangram exercise
module Pangram
  def self.pangram?(input)
    text = input.downcase
    letters = text.chars.uniq.select { |char| ('a'..'z').include?(char) }

    letters.length == 26
  end
end
