#include "sum_of_multiples.hpp"
#include <numeric>
#include <set>
#include <vector>

namespace sum_of_multiples {

int to(std::vector<int> items, int points) {
    int sum{0};

    if (points == 0) {
        return sum;
    }

    std::set<int> multiples{};

    for (auto iter : items) {
        for (int multiple = 1; multiple < points; multiple++) {
            if (multiple % iter == 0) {
                multiples.insert(multiple);
            }
        }
    }

    auto sum_op = [](int sum, int num) { return sum + num; };

    sum = std::accumulate(multiples.begin(), multiples.end(), sum, sum_op);

    return sum;
}

} // namespace sum_of_multiples
