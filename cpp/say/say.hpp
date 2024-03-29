#include <cstdint>
#if !defined(SAY_HPP)
#define SAY_HPP

#include <map>
#include <string>

#include <boost/multiprecision/cpp_int.hpp>

namespace say {

using message_t = std::string;

// Using signed 128-bit numbers because most of the tests use unsigned long long
// (64-bit) and some use signed int (32/64-bit).
using int128_t = boost::multiprecision::int128_t;
using parts_t = std::map<uint64_t, std::string>;

const uint64_t k_trillion = 1'000'000'000'000ULL;
const uint64_t k_billion = 1'000'000'000ULL;
const uint64_t k_million = 1'000'000ULL;
const uint64_t k_thousand = 1'000ULL;
const uint64_t k_hundred = 100ULL;

[[nodiscard]] std::string in_english(int128_t number);

[[nodiscard]] std::string say_tens(uint64_t number, parts_t parts);
[[nodiscard]] std::string say_hundreds(uint64_t &number, parts_t parts);
[[nodiscard]] std::string say_rest(uint64_t &number, parts_t parts);

void check_runtime_error(bool condition, message_t message);

} // namespace say

#endif // SAY_HPP
