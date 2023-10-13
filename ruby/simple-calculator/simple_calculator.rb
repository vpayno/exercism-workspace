# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/simple-calculator
# SimpleCalculator exercise
class SimpleCalculator
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze

  class UnsupportedOperation < ::StandardError
  end

  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation, 'nil is not a valid operation' unless ALLOWED_OPERATIONS.include?(operation)

    result = first_operand.public_send(operation, second_operand)
    "#{first_operand} #{operation} #{second_operand} = #{result}"
  rescue ZeroDivisionError
    'Division by zero is not allowed.'
  rescue TypeError => e
    raise ArgumentError, e.message
  end
end
