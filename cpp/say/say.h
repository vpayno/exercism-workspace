#if !defined(SAY_H)
#define SAY_H

#include <map>
#include <numeric>
#include <stdexcept>
#include <string>

#include <boost/multiprecision/cpp_int.hpp>

namespace say {

using message_t = std::string;

// Using 128-bit numbers (supported on x86_64) because most of the tests use ULL
// and some use signed int
using int128_t = boost::multiprecision::int128_t;
using parts_t = std::map<uint64_t, std::string>;

const uint64_t k_quadrillion = 1'000'000'000'000'000ULL;
const uint64_t k_trillion = 1'000'000'000'000ULL;
const uint64_t k_billion = 1'000'000'000ULL;
const uint64_t k_million = 1'000'000ULL;
const uint64_t k_thousand = 1'000ULL;
const uint64_t k_hundred = 100ULL;

[[nodiscard]] std::string in_english(int128_t number);
[[nodiscard]] std::string say_tens(uint64_t number, parts_t parts);
[[nodiscard]] std::string say_hundreds(uint64_t &number, parts_t parts);
[[nodiscard]] std::string say_thousands(uint64_t &number, parts_t parts);
[[nodiscard]] std::string say_million(uint64_t &number, parts_t parts);
[[nodiscard]] std::string say_billion(uint64_t &number, parts_t parts);
[[nodiscard]] std::string say_trillion(uint64_t &number, parts_t parts);

void check_runtime_error(bool condition, message_t message);

} // namespace say

#endif // SAY_H
