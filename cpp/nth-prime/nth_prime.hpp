#if !defined(NTH_PRIME_HPP)
#define NTH_PRIME_HPP

#include <vector>

namespace nth_prime {

int nth(int loc);

} // namespace nth_prime

#endif // NTH_PRIME_HPP

// CMakeLists.txt doesn't pull in other cpp or hpp files so just appending it
// here.
#if !defined(SIEVE_HPP)
#define SIEVE_HPP

#include <vector>

namespace sieve {

std::vector<int> primes(int limit);

} // namespace sieve

#endif // SIEVE_HPP
