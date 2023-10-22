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
require_relative 'nth_prime'

class NthPrimeTest < Minitest::Test
  def test_first_prime
    # skip
    assert_equal 2, Prime.nth(1)
  end

  def test_second_prime
    # skip
    assert_equal 3, Prime.nth(2)
  end

  def test_sixth_prime
    # skip
    assert_equal 13, Prime.nth(6)
  end

  def test_big_prime
    # skip
    assert_equal 104_743, Prime.nth(10_001)
  end

  def test_there_is_no_zeroth_prime
    # skip
    assert_raises(ArgumentError) do
      Prime.nth(0)
    end
  end
end
