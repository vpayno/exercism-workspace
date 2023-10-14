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
require_relative 'port_palermo'

class MoviegoerTest < Minitest::Test
  def test_identifier
    assert_equal :PALE, Port::IDENTIFIER
  end

  def test_get_identifier_for_hamburg
    assert_equal :HAMB, Port.get_identifier("Hamburg")
  end

  def test_get_identifier_for_rome
    assert_equal :ROME, Port.get_identifier("Rome")
  end

  def test_get_identifier_for_kiel
    assert_equal :KIEL, Port.get_identifier("Kiel")
  end

  def test_get_terminal_for_oil
    assert_equal :A, Port.get_terminal(:OIL123)
  end

  def test_get_terminal_for_gas
    assert_equal :A, Port.get_terminal(:GAS674)
  end

  def test_get_terminal_for_cars
    assert_equal :B, Port.get_terminal(:CAR942)
  end

  def test_get_terminal_for_clothes
    assert_equal :B, Port.get_terminal(:CLO315)
  end
end
