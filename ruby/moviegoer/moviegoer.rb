# frozen_string_literal: false

# This is a custom exception that you can use in your code
class NotMovieClubMemberError < RuntimeError
end

# https://exercism.org/tracks/ruby/exercises/moviegoer
# Moviegoer Exercise
class Moviegoer
  attr_reader :age, :member, :ticket_price

  def initialize(age, member: nil)
    @age = age
    @member = member

    @ticket_price = @age >= 60 ? 10 : 15
  end

  def watch_scary_movie?
    @age >= 18
  end

  def claim_free_popcorn!
    @member ? '🍿' : (raise NotMovieClubMemberError)
  end
end
