#if !defined(PERFECT_NUMBERS_HPP)
#define PERFECT_NUMBERS_HPP

#include <algorithm>
#include <numeric>
#include <stdexcept>
#include <vector>

namespace perfect_numbers {

enum kind {
    perfect,
    abundant,
    deficient,
};

kind classify(int number);

} // namespace perfect_numbers

#endif // PERFECT_NUMBERS_HPP
