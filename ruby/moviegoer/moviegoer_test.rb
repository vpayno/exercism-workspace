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
require_relative 'moviegoer'

class MoviegoerTest < Minitest::Test
  def test_regular_ticket_price
    assert_equal 15, Moviegoer.new(59).ticket_price
  end

  def test_seniors_discount
    assert_equal 10, Moviegoer.new(60).ticket_price
  end

  def test_adults_can_see_the_scary_movie
    assert Moviegoer.new(18).watch_scary_movie?
  end

  def test_kids_cant_see_the_scary_movie
    refute Moviegoer.new(17).watch_scary_movie?
  end

  def test_members_get_free_popcorn
    assert_equal "🍿", Moviegoer.new(25, member: true).claim_free_popcorn!
  end

  def test_regular_moviegoers_dont_get_free_popcorn
    assert_raises NotMovieClubMemberError do
      Moviegoer.new(25, member: false).claim_free_popcorn!
    end
  end
end
