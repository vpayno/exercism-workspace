# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/scrabble-score
# Scrabble Score exercise
class Scrabble
  def initialize(word)
    @word = word.chomp.downcase
  end

  def score
    @word.chars.map { |letter| score_letter letter }.sum
  end

  def score_letter(letter)
    case letter
    when /^(a|e|i|o|u|l|n|r|s|t)$/
      1
    when /^(d|g)$/
      2
    when /^(b|c|m|p)$/
      3
    when /^(f|h|v|w|y)$/
      4
    when /^k$/
      5
    when /^(j|x)$/
      8
    when /^(q|z)$/
      10
    else
      0
    end
  end

  private :score_letter
end
