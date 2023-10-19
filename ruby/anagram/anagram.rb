# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/anagram
# Anagram exercise
class Anagram
  def initialize(input)
    @target = input.downcase.chomp
    @sorted_target = @target.chars.sort.join('')
  end

  # if the target and candidate aren't equal, are the
  # sorted target and sorted candidates equal?
  def match(candidates)
    candidates.select do |candidate|
      candidate = candidate.downcase.chomp
      sorted_candidate = candidate.chars.sort.join('')

      @sorted_target.eql?(sorted_candidate) unless @target.eql?(candidate)
    end
  end
end
