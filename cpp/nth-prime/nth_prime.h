#if !defined(NTH_PRIME_H)
#define NTH_PRIME_H

// please stop trying to use *.h files as c++ headers (*.hpp)

#include <stdexcept>
#include <vector>

namespace nth_prime {

int nth(int loc);

} // namespace nth_prime

#endif // NTH_PRIME_H

// CMakeLists.txt doesn't pull in other cpp or hpp files so just appending it
// here.
#if !defined(SIEVE_HPP)
#define SIEVE_HPP

#include <vector>

namespace sieve {

std::vector<int> primes(int limit);

} // namespace sieve

#endif // SIEVE_HPP
