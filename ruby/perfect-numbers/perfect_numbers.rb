# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/perfect-numbers
# Perfect Numbers exercise
module PerfectNumber
  Struct.new('Kind', :aliquot_sum, :number) do
    def deficient
      -1
    end

    def perfect
      0
    end

    def abundant
      1
    end

    def kind
      if aliquot_sum > number
        abundant
      elsif aliquot_sum < number
        deficient
      else
        perfect
      end
    end

    def to_s
      kinds = {
        deficient => 'deficient',
        perfect => 'perfect',
        abundant => 'abundant'
      }

      kinds[kind]
    end

    def to_i
      kind
    end

    private :deficient, :perfect, :abundant, :kind
  end

  def self.classify(number)
    raise 'perfect numbers are postive' unless number.positive?

    aliquot_sum = (1...number).reduce do |sum, factor|
      sum + (number.modulo(factor).zero? ? factor : 0)
    end

    Struct::Kind.new(aliquot_sum, number).to_s
  end
end
