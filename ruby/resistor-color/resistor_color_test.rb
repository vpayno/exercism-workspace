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
require_relative 'resistor_color'

class ResistorColorTest < Minitest::Test
  def test_black
    # skip
    assert_equal 0, ResistorColor.color_code('black')
  end

  def test_white
    # skip
    assert_equal 9, ResistorColor.color_code('white')
  end

  def test_orange
    # skip
    assert_equal 3, ResistorColor.color_code('orange')
  end

  def test_colors
    # skip
    expected = %w[black brown red orange yellow green blue violet grey white]
    assert_equal expected, ResistorColor::COLORS
  end
end
