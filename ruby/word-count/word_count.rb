# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/word-count
# Word Count exercise
class Phrase
  def initialize(text)
    @text = text.chomp.strip

    @text.chars.select! do |rune|
      rune.letter? || rune.digit? || rune.space? || rune.apostrophe?
    end&.join('')
  end

  def word_count
    @words = @text.scan(/\b[[:alpha:][:digit:]']+\b/).collect

    @counts = Hash.new(0)

    @words.each { |word| @counts[word.downcase] += 1 }

    @counts
  end
end

# Extending the String class
class String
  def apostrophe?
    match?(/'/)
  end

  def space?
    match?(/[[:space:]]/)
  end

  def letter?
    match?(/[[:alpha:]]/)
  end

  def digit?
    match?(/[[:digit:]]/)
  end
end
