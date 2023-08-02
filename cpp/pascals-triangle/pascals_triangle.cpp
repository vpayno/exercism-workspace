#include "pascals_triangle.hpp"

namespace pascals_triangle {

triangle_t generate_rows(int limit) {
    triangle_t triangle{};

    if (limit <= 0) {
        return triangle;
    }

    // NOLINTNEXTLINE(readability-identifier-length)
    for (int n = 0; n < limit; n++) {
        row_t row{1};

        for (int k = 1; k <= n; k++) {
            const int coefficient = n_choose_k(n, k);
            row.emplace_back(coefficient);
        }

        triangle.emplace_back(row);
    }

    return triangle;
}

/* returns the factorial of a number.
 * https://en.wikipedia.org/wiki/Factorial
 */
int factorial(int number) {
    if (number < 0) {
        return -1;
    }

    int result{1};

    for (int i = 2; i <= number; i++) {
        result *= i;
    }

    return result;
}

/* returns the number of possible ways to choose 2 numbers from a set.
 * https://en.wikipedia.org/wiki/Binomial_coefficient
 */
// NOLINTNEXTLINE(readability-identifier-length,bugprone-easily-swappable-parameters)
int n_choose_k(int n, int k) {
    if (k < 0 or n < k) {
        return -1;
    }

    int result{};

    const int factorial1 = factorial(n);
    const int factorial2 = factorial(k);
    const int factorial3 = factorial(n - k);

    result = factorial1 / (factorial2 * factorial3);

    return result;
}

} // namespace pascals_triangle
