#include "darts.hpp"
#include <cmath>

namespace darts {

// NOLINTNEXTLINE(readability-identifier-length)
int score(double x, double y) {
    const double distance = std::hypot(x, y);

    if (distance <= 1.0) {
        return 10;
    }

    if (distance <= 5.0) {
        return 5;
    }

    if (distance <= 10.0) {
        return 1;
    }

    return 0;
}

} // namespace darts
