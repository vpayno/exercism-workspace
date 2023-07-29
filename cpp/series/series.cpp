#include "series.hpp"

namespace series {

std::vector<std::string> slice(std::string sequence, int span) {
    std::vector<std::string> groups{};

    if (span == 0) {
        throw std::domain_error{"span can't be zero"};
    }

    if (span < 0) {
        throw std::domain_error{"span can't be negative"};
    }

    if (sequence.empty()) {
        throw std::domain_error{"sequence can't be empty"};
    }

    if ((long long)sequence.length() < span) {
        throw std::domain_error{"span is longer than sequence"};
    }

    if ((long long)sequence.length() == span) {
        groups.emplace_back(sequence);
        return groups;
    }

    size_t remaining = sequence.length();
    auto current = sequence.begin();

    for (const char digit : sequence) {
        if (remaining < (size_t)span) {
            break;
        }
        remaining -= 1;

        auto next = current;
        std::string group{};

        group += digit;

        for (int i = 1; i < span; i++) {
            std::advance(next, 1);
            group += *next;
        }

        groups.emplace_back(group);

        std::advance(current, 1);
    }

    return groups;
}

} // namespace series
