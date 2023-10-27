# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/word-count
# Word Count exercise
class Phrase
  def initialize(text)
    @text = text
  end

  def word_count
    words = @text.scan(/\b[[:alpha:][:digit:]']+\b/).collect

    words.each_with_object(Hash.new(0)) { |word, counts| counts[word.downcase] += 1 }
  end
end
