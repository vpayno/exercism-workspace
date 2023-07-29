#if !defined(SERIES_H)
#define SERIES_H

#include <iterator>
#include <stdexcept>
#include <string>
#include <vector>

namespace series {

std::vector<std::string> slice(std::string sequence, int span);

} // namespace series

#endif // SERIES_H
