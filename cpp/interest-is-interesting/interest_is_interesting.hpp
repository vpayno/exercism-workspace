#if !defined(INTEREST_IS_INTERESTING_HPP)
#define INTEREST_IS_INTERESTING_HPP

#include <cmath>

namespace interest_is_interesting {

    double interest_rate(double balance);
    double yearly_interest(double balance);
    double annual_balance_update(double balance);
    int years_until_desired_balance(double balance, double target_balance); // NOLINT(bugprone-easily-swappable-parameters)

} // namespace interest_is_interesting

#endif // INTEREST_IS_INTERESTING_HPP
