#if !defined(RAINDROPS_H)
#define RAINDROPS_H

/*
 * We can't modify/submit raindrops_test.cpp (that would lead to cheating) so
 * we this file needs to work in a C++ world (kind of).
 *
 * I would rather just include raindrops.hpp in the test file
 * raindrops_test.cpp.
 */

#ifdef __cplusplus

// :( still getting: E: 'string' file not found [clang-diagnostic-error]
// clang just doesn't want .h files with c++ >=17
#include <string>

// clang-format keeps messing up formatting here since a C header file doesn't
// have namespace support

namespace raindrops {
    std::string convert(int num);
}

#endif

#endif // RAINDROPS_H
