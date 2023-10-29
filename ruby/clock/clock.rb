# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/clock
# Clock exercise
class Clock
  attr_reader :hour, :minute

  MINUTES_IN_HOUR = 60
  HOURS_IN_DAY = 24

  def initialize(hour: 0, minute: 0)
    @hour, @minute = normalize(hour, minute)
  end

  def normalize(hour, minute)
    total_minutes = hour * MINUTES_IN_HOUR + minute
    total_hours = total_minutes / MINUTES_IN_HOUR

    [total_hours.modulo(HOURS_IN_DAY), total_minutes.modulo(MINUTES_IN_HOUR)]
  end

  def to_s
    "#{@hour.to_s.rjust(2, '0')}:#{@minute.to_s.rjust(2, '0')}"
  end

  def +(other)
    Clock.new(hour: @hour + other.hour, minute: @minute + other.minute)
  end

  def -(other)
    Clock.new(hour: @hour - other.hour, minute: @minute - other.minute)
  end

  def ==(other)
    @hour == other.hour && @minute == other.minute
  end
end
