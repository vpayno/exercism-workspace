#include "interest_is_interesting.hpp"

namespace interest_is_interesting {

// interest_rate returns the interest rate for the provided balance.
double interest_rate(double balance) {
    double rate{0.0};

    if (balance < 0.0) {
        rate = 3.213;
    } else if (balance >= 0 and balance < 1'000) {
        rate = 0.5;
    } else if (balance >= 1'000 and balance < 5'000) {
        rate = 1.621;
    } else if (balance >= 5'000) {
        rate = 2.475;
    }

    return rate;
}

// yearly_interest calculates the yearly interest for the provided balance.
double yearly_interest(double balance) {
    return balance * interest_rate(balance) / 100.0;
}

// annual_balance_update calculates the annual balance update, taking into
// account the interest rate.
double annual_balance_update(double balance) {
    return balance + yearly_interest(balance);
}

// years_until_desired_balance calculates the minimum number of years required
// to reach the desired balance.
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
int years_until_desired_balance(double balance, double target_balance) {
    double moving_balance{balance};
    int years_needed{0};

    while (moving_balance < target_balance) {
        moving_balance += yearly_interest(moving_balance);
        years_needed += 1;
    }

    return years_needed;
    ;
}

} // namespace interest_is_interesting
