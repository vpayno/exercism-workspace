#include "binary_search.hpp"

namespace binary_search {

size_t find(data_t data, number_t key) {
    if (data.empty()) {
        throw std::domain_error("data is empty");
    }

    size_t low{};
    size_t high{data.size() - 1};
    if (data.at(low) > key || data.at(high) < key) {
        throw std::domain_error("key not found in data");
    }

    size_t mid{(high + low) / 2};
    int mid_value{data.at(mid)};
    while (mid_value != key) {
        if (mid_value > key) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }

        if (low > high) {
            throw std::domain_error("key not found in data");
        }

        mid = (high + low) / 2;
        mid_value = data.at(mid);
    }

    return mid;
}

} // namespace binary_search
