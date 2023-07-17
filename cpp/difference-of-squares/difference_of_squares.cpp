#include "difference_of_squares.hpp"

namespace difference_of_squares {

unsigned int sum_of_squares(const unsigned int number) {
    return (number * (number + 1) * (2 * number + 1) / 6);
}

unsigned int square_of_sum(const unsigned int number) {
    const unsigned int sum = number * (number + 1) / 2;

    return sum * sum;
}

unsigned int difference(const unsigned int number) {
    return square_of_sum(number) - sum_of_squares(number);
}

} // namespace difference_of_squares
