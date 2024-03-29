#include "grains.hpp"
#include <cstddef>

namespace grains {

GrainCount square(size_t index) {
    const size_t index_min = 1;
    const size_t index_max = 64;

    if (index < index_min || index > index_max) {
        return 0;
    }

    return 1ULL << (index - 1);
}

GrainCount total() { return (((1ULL << 63) - 1) << 1) + 1; }

} // namespace grains
