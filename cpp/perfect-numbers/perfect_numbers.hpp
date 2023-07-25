#if !defined(PERFECT_NUMBERS_H)
#define PERFECT_NUMBERS_H

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

#endif // PERFECT_NUMBERS_H
