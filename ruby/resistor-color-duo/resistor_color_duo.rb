# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/resistor-color-duo
# Resistor Color Duo exercise
module ResistorColorDuo
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

  def self.value(bands)
    resistor_value = color_code(bands[0]) * 10

    resistor_value += color_code(bands[1])

    resistor_value
  end
end
