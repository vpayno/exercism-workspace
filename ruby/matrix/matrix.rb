# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/matrix
# Matrix exercise
class Matrix
  def initialize(input)
    @rows = input.lines.map do |line|
      line.split.map(&:to_i)
    end

    @columns = @rows.transpose
  end

  def row(index)
    @rows.fetch(index - 1, [])
  end

  def column(index)
    @columns.fetch(index - 1, [])
  end
end
