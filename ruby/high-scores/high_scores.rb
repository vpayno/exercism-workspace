# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/high-scores
# High Scores exercise
class HighScores
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def personal_best
    @scores.max
  end

  def latest
    @scores.last
  end

  def personal_top_three
    @scores.max(3)
  end

  def latest_is_personal_best?
    latest == personal_best
  end
end
