# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/microwave
# Microwave exercise
class Microwave
  def initialize(input)
    @input = input
    @minutes = 0
    @seconds = 0
  end

  def display_output
    "#{@minutes.to_s.rjust(2, '0')}:#{@seconds.to_s.rjust(2, '0')}"
  end

  def timer_under_onehundred
    @minutes = (@input / 60)
    @seconds = @input.modulo(60)

    display_output
  end

  def timer_over_equals_onehundred
    @minutes = (@input / 100)
    @seconds = (@input - (100 * @minutes))

    if @seconds >= 60
      @minutes += (@seconds / 60)
      @seconds = @seconds.modulo(60)
    end

    display_output
  end

  def timer
    return timer_under_onehundred if @input < 100

    timer_over_equals_onehundred
  end
end
