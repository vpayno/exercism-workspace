#include <cmath>

// daily_rate calculates the daily rate given an hourly rate
double daily_rate(double hourly_rate) {
    const double hours = 8.0;

    return hours * hourly_rate;
}

// apply_discount calculates the price after a discount
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
double apply_discount(double before_discount, double discount) {
    const double charge_rate = (100 - discount) / 100;

    return before_discount * charge_rate;
}

// monthly_rate calculates the monthly rate, given an hourly rate and a discount
// The returned monthly rate is rounded up to the nearest integer.
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
int monthly_rate(double hourly_rate, double discount) {

    const double billable_days = 22.0;

    const double monthly_cost = daily_rate(hourly_rate) * billable_days;

    const double discounted_cost = apply_discount(monthly_cost, discount);

    return std::ceil(discounted_cost);
}

// days_in_budget calculates the number of workdays given a budget, hourly rate,
// and discount The returned number of days is rounded down (take the floor) to
// the next integer.
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
int days_in_budget(int budget, double hourly_rate, double discount) {
    const double daily_cost = daily_rate(hourly_rate);

    const double discounted_hourly = apply_discount(daily_cost, discount);

    const double days = budget / std::ceil(discounted_hourly);

    return std::floor(days);
}
