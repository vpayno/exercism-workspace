# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/allergies
# Allergies exercise
class Allergies
  def initialize(score)
    @score = score

    @allergies = {
      'eggs' => 1,
      'peanuts' => 2,
      'shellfish' => 4,
      'strawberries' => 8,
      'tomatoes' => 16,
      'chocolate' => 32,
      'pollen' => 64,
      'cats' => 128
    }
  end

  def allergic_to?(allergen)
    (@allergies.fetch(allergen, 0) & @score).positive?
  end

  def list
    allergic_reactions = []

    @allergies.each_pair do |key, value|
      allergic_reactions.push(key) unless (value & @score).zero?
    end

    allergic_reactions
  end
end
