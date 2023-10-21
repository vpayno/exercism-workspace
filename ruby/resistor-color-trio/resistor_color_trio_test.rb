# frozen_string_literal: false

# https://github.com/simplecov-ruby/simplecov
require 'simplecov'

# https://about.codecov.io/blog/getting-started-with-code-coverage-for-ruby/
require 'simplecov-cobertura'
SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter

# line coverage
SimpleCov.start if ENV['COVERAGE'] != 'branch'

# branch coverage
if ENV['COVERAGE'] == 'branch'
  SimpleCov.start do
    enable_coverage :branch
    primary_coverage :branch
  end
end

# name the test file/group
SimpleCov.command_name 'test:exercism'

# original exercism tests
require 'minitest/autorun'
require_relative 'resistor_color_trio'

class ResistorColorTrioTest < Minitest::Test
  def test_orange_and_orange_and_black
    # skip
    assert_equal 'Resistor value: 33 ohms', ResistorColorTrio.new(%w[orange orange black]).label
  end

  def test_blue_and_grey_and_brown
    # skip
    assert_equal 'Resistor value: 680 ohms', ResistorColorTrio.new(%w[blue grey brown]).label
  end

  def test_red_and_black_and_red
    # skip
    assert_equal 'Resistor value: 2 kiloohms', ResistorColorTrio.new(%w[red black red]).label
  end

  def test_green_and_brown_and_orange
    # skip
    assert_equal 'Resistor value: 51 kiloohms', ResistorColorTrio.new(%w[green brown orange]).label
  end

  def test_yellow_and_violet_and_yellow
    # skip
    assert_equal 'Resistor value: 470 kiloohms', ResistorColorTrio.new(%w[yellow violet yellow]).label
  end
end
