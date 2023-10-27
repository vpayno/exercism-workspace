# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/series
# Series exercise
class Series
  def initialize(sequence)
    @sequence = sequence
    @sequence_length = @sequence.length
    @span = 0
  end

  def slices(span)
    @span = span

    raise ArgumentError, "span can't be zero" if @span.zero?
    raise ArgumentError, "span can't be negative" if @span.negative?
    raise ArgumentError, "sequence can't be empty" if @sequence.empty?
    raise ArgumentError, 'span is longer than sequence' if @span > @sequence_length

    groups = []

    return groups.push(@sequence) if @span == @sequence_length

    remaining = @sequence_length

    (0...@sequence_length).each do |index|
      break if remaining < span

      remaining -= 1

      groups.push(@sequence.slice(index, @span))
    end

    groups
  end
end
