# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/matching-brackets
# Matching Brackets exercise
module Brackets
  def self.paired?(text)
    stack = []

    text.chars.each do |rune|
      next unless bracket_either?(rune)

      if bracket_open?(rune)
        stack.push(rune)
        next
      end

      next unless bracket_close?(rune)

      return false if stack.empty?
      return false unless bracket_match?(stack.last, rune)

      _ = stack.pop
    end

    stack.empty?
  end

  def self.bracket_match?(open_bracket, close_bracket)
    return true if open_bracket == '[' && close_bracket == ']'
    return true if open_bracket == '(' && close_bracket == ')'
    return true if open_bracket == '{' && close_bracket == '}'

    false
  end

  def self.bracket_open?(bracket)
    ['[', '(', '{'].include?(bracket)
  end

  def self.bracket_close?(bracket)
    [']', ')', '}'].include?(bracket)
  end

  def self.bracket_either?(bracket)
    bracket_open?(bracket) || bracket_close?(bracket)
  end
end
