#if !defined(RAINDROPS_HPP)
#define RAINDROPS_HPP

#include <string>

/*
 * don't include this when including into raindrops.cpp since we also have to
 * include raindrops.h into the test file that we can't modify so they're
 * duplicate definitions.
 *
 * don't know why they insist on randomly using .h files instead of .hpp files
 *
extern "C"
{
#include "raindrops.h"
}
 *
*/

namespace raindrops {
    std::string convert(int num);
} // namespace raindrops

#endif // RAINDROPS_HPP
