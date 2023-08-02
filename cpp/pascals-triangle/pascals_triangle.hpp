#if !defined(PASCALS_TRIANGLE_HPP)
#define PASCALS_TRIANGLE_HPP

#include <string>
#include <vector>

namespace pascals_triangle {

using row_t = std::vector<int>;
using triangle_t = std::vector<row_t>;

triangle_t generate_rows(int limit);
int factorial(int number);
int n_choose_k(int n, int k); // NOLINT(readability-identifier-length)

} // namespace pascals_triangle

#endif // PASCALS_TRIANGLE_HPP
