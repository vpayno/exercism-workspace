# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/simple-cipher
# Simple Cipher 12in23 challenge
class Cipher
  attr_reader :key

  def initialize(key = nil)
    @key = key || 100.times.map { ('a'.ord + rand(26)).chr }.join

    raise ArgumentError, 'empty key' if @key.empty?
    raise ArgumentError, 'key not composed of only a-z letters' if @key.match?(/[^a-z]/)
  end

  def encode(plain_text)
    plain_text.chars.zip(@key.chars).map do |rune, key|
      to_char(shift_right(rune, key)).chr
    end.join
  end

  def decode(cipher_text)
    cipher_text.chars.zip(@key.chars).map do |rune, key|
      to_char(shift_left(rune, key)).chr
    end.join
  end

  private

  def shift_right(rune, key)
    to_ord(rune) + to_ord(key)
  end

  def shift_left(rune, key)
    to_ord(rune) - to_ord(key)
  end

  def to_ord(rune)
    rune.ord - 'a'.ord
  end

  def to_char(ordinal)
    (ordinal % 26 + 'a'.ord).chr
  end
end
