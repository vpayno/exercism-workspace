# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/resistor-color
# Resistor Color exercise
module ResistorColor
  COLORS = %w[
    black
    brown
    red
    orange
    yellow
    green
    blue
    violet
    grey
    white
  ].freeze

  def self.color_code(color)
    COLORS.index(color)
  end
end
