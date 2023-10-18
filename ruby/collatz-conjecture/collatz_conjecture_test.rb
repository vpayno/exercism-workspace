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
require_relative 'collatz_conjecture'

class CollatzConjectureTest < Minitest::Test
  def test_zero_steps_for_one
    # skip
    assert_equal 0, CollatzConjecture.steps(1)
  end

  def test_divide_if_even
    # skip
    assert_equal 4, CollatzConjecture.steps(16)
  end

  def test_even_and_odd_steps
    # skip
    assert_equal 9, CollatzConjecture.steps(12)
  end

  def test_large_number_of_even_and_odd_steps
    # skip
    assert_equal 152, CollatzConjecture.steps(1_000_000)
  end

  def test_zero_is_an_error
    # skip
    assert_raises(ArgumentError) do
      CollatzConjecture.steps(0)
    end
  end

  def test_negative_value_is_an_error
    # skip
    assert_raises(ArgumentError) do
      CollatzConjecture.steps(-15)
    end
  end
end
