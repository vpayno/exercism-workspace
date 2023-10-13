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
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'lasagna'

class LasagnaTest < Minitest::Test
  def test_expected_minutes_in_oven
    assert_equal 40, Lasagna::EXPECTED_MINUTES_IN_OVEN
  end

  def test_remaining_minutes_in_oven
    assert_equal 15, Lasagna.new.remaining_minutes_in_oven(25)
  end

  def test_preparation_time_in_minutes_with_one_layer
    assert_equal 2, Lasagna.new.preparation_time_in_minutes(1)
  end

  def test_preparation_time_in_minutes_with_multiple_layers
    assert_equal 8, Lasagna.new.preparation_time_in_minutes(4)
  end

  def test_total_time_in_minutes_for_one_layer
    assert_equal 32, Lasagna.new.total_time_in_minutes(
      number_of_layers: 1,
      actual_minutes_in_oven: 30
    )
  end

  def test_total_time_in_minutes_for_multiple_layer
    assert_equal 16, Lasagna.new.total_time_in_minutes(
      number_of_layers: 4,
      actual_minutes_in_oven: 8
    )
  end
end
