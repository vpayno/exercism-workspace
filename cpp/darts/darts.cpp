#include "darts.hpp"

namespace darts {

int score(double x, double y) {
    double distance = std::hypot(x, y);

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
