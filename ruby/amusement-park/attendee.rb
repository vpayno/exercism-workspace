# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/amusement-park
# Amuzement Park exercise
class Attendee
  attr_reader :height, :pass_id

  def initialize(height)
    @height = height
  end

  def issue_pass!(pass_id)
    @pass_id = pass_id
  end

  def revoke_pass!
    @pass_id = nil
  end
end
