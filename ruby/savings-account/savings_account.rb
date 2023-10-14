# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/savings-account
# Savings Account exercise
module SavingsAccount
  def self.interest_rate(balance)
    if balance.negative?
      3.213
    elsif balance < 1_000
      0.5
    elsif balance < 5_000
      1.621
    elsif balance >= 5_000
      2.475
    end
  end

  def self.annual_balance_update(balance)
    balance * (1.0 + (interest_rate(balance) / 100.0))
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0

    while current_balance < desired_balance
      years += 1
      current_balance = annual_balance_update(current_balance)
    end

    years
  end
end
