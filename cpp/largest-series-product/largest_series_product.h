#if !defined(LARGEST_SERIES_PRODUCT_H)
#define LARGEST_SERIES_PRODUCT_H

#include <regex>
#include <stdexcept>
#include <string>

namespace largest_series_product {

int largest_product(std::string digits, int span);
bool is_valid_input(std::string digits, int span);

} // namespace largest_series_product

#endif // LARGEST_SERIES_PRODUCT_H
