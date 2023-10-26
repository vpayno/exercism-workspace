# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/bob
# Bob exercises
module Bob
  def self.hey(remark)
    remark.chomp! # remove surrounding newlines
    remark.strip! # remove surrounding whitespace
    remark.delete!("\n") # remove all remaining newlines

    # Silence
    return 'Fine. Be that way!' if remark.match(/^[[:space:]]*$/)

    # Question with only spaces and punctuation
    return 'Sure.' if remark.match(/^([[:punct:]]|[[:space:]])+[?]$/)

    # Question with uppercase letters, punctuation and spaces
    return "Calm down, I know what I'm doing!" if remark.match(/^([[:upper:]]|[[:punct:]]|[[:space:]])+[?]$/)

    # All remaining questions
    return 'Sure.' if remark.match(/^.+[?][[:space:]]*$/)

    # Generic statement
    return 'Whatever.' if remark.match(/^([[:digit:]]|[[:punct:]]|[[:space:]])+$/)

    # Yelling statement
    return 'Whoa, chill out!' if remark.match(/^([[:upper:]]|[[:digit:]]|[[:punct:]]|[[:space:]])+$/)

    'Whatever.'
  end
end
