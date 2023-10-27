# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/word-count
# Word Count exercise
class Phrase
  def initialize(text)
    @text = text.chomp.strip
  end

  def word_count
    @words = @text.scan(/\b[[:alpha:][:digit:]']+\b/).collect

    @counts = Hash.new(0)

    @words.each { |word| @counts[word.downcase] += 1 }

    @counts
  end
end
