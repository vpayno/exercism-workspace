# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/etl
# ETL exercise
module ETL
  def self.transform(old_score)
    new_scores = {}

    _ = old_score.each do |score, letters|
      new_scores = letters.each_with_object(new_scores) do |letter, new_hash|
        new_hash[letter.downcase] = score
      end
    end

    new_scores
  end
end
