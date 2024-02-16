#include <cstddef>
#if !defined(GRAINS_HPP)
#define GRAINS_HPP

namespace grains {

using GrainCount = unsigned long long;

GrainCount square(size_t index);
GrainCount total();

} // namespace grains

#endif // GRAINS_HPP
