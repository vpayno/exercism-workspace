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
require_relative 'perfect_numbers'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises RuntimeError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    assert_equal 'abundant', PerfectNumber.classify(12)
  end
end
