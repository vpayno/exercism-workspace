# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/resistor-color-trio
# Resistor Color Trio exercise
class ResistorColorTrio
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

  def initialize(bands)
    @bands = bands
  end

  def label
    value = resistor_value(@bands)
    value *= 10**COLORS.index(@bands[2])
    units = 'ohms'

    while value >= 1000
      value /= 1000
      units = 'kiloohms'
    end

    "Resistor value: #{value} #{units}"
  end

  def resistor_value(bands)
    resistor_value = COLORS.index(bands[0]) * 10

    resistor_value += COLORS.index(bands[1])

    resistor_value
  end

  private :resistor_value
end
