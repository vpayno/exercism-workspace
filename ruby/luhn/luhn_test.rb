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
require_relative 'luhn'

class LuhnTest < Minitest::Test
  def test_single_digit_strings_can_not_be_valid
    # skip
    refute Luhn.valid?('1')
  end

  def test_a_single_zero_is_invalid
    # skip
    refute Luhn.valid?('0')
  end

  def test_a_simple_valid_sin_that_remains_valid_if_reversed
    # skip
    assert Luhn.valid?('059')
  end

  def test_a_simple_valid_sin_that_becomes_invalid_if_reversed
    # skip
    assert Luhn.valid?('59')
  end

  def test_a_valid_canadian_sin
    # skip
    assert Luhn.valid?('055 444 285')
  end

  def test_invalid_canadian_sin
    # skip
    refute Luhn.valid?('055 444 286')
  end

  def test_invalid_credit_card
    # skip
    refute Luhn.valid?('8273 1232 7352 0569')
  end

  def test_invalid_long_number_with_an_even_remainder
    # skip
    refute Luhn.valid?('1 2345 6789 1234 5678 9012')
  end

  def test_invalid_long_number_with_a_remainder_divisible_by_5
    # skip
    refute Luhn.valid?('1 2345 6789 1234 5678 9013')
  end

  def test_valid_number_with_an_even_number_of_digits
    # skip
    assert Luhn.valid?('095 245 88')
  end

  def test_valid_number_with_an_odd_number_of_spaces
    # skip
    assert Luhn.valid?('234 567 891 234')
  end

  def test_valid_strings_with_a_non_digit_added_at_the_end_become_invalid
    # skip
    refute Luhn.valid?('059a')
  end

  def test_valid_strings_with_punctuation_included_become_invalid
    # skip
    refute Luhn.valid?('055-444-285')
  end

  def test_valid_strings_with_symbols_included_become_invalid
    # skip
    refute Luhn.valid?('055# 444$ 285')
  end

  def test_single_zero_with_space_is_invalid
    # skip
    refute Luhn.valid?(' 0')
  end

  def test_more_than_a_single_zero_is_valid
    # skip
    assert Luhn.valid?('0000 0')
  end

  def test_input_digit_9_is_correctly_converted_to_output_digit_9
    # skip
    assert Luhn.valid?('091')
  end

  def test_very_long_input_is_valid
    # skip
    assert Luhn.valid?('9999999999 9999999999 9999999999 9999999999')
  end

  def test_valid_luhn_with_an_odd_number_of_digits_and_non_zero_first_digit
    # skip
    assert Luhn.valid?('109')
  end

  def test_using_ascii_value_for_non_doubled_non_digit_isnt_allowed
    # skip
    refute Luhn.valid?('055b 444 285')
  end

  def test_using_ascii_value_for_doubled_non_digit_isnt_allowed
    # skip
    refute Luhn.valid?(':9')
  end

  def test_non_numeric_non_space_char_in_the_middle_with_a_sum_thats_divisible_by_10_isnt_allowed
    # skip
    refute Luhn.valid?('59%59')
  end
end
