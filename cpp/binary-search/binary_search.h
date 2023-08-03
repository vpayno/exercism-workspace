#if !defined(BINARY_SEARCH_H)
#define BINARY_SEARCH_H

#include <cstddef>
#include <stdexcept>
#include <vector>

namespace binary_search {

using number_t = int;
using data_t = std::vector<number_t>;

size_t find(data_t data, number_t key);

} // namespace binary_search

#endif // BINARY_SEARCH_H
