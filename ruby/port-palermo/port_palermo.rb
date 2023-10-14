# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/port-palermo
# Port of Palermo exercise
module Port
  IDENTIFIER = :PALE

  def self.get_identifier(city)
    city[0, 4].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    identifier = ship_identifier.to_s[0, 3]

    if identifier.eql?('OIL') || identifier.eql?('GAS')
      :A
    else
      :B
    end
  end
end
