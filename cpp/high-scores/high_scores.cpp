#include "high_scores.hpp"

#include <iostream>

namespace arcade {

// Return all scores for this session.
std::vector<int> HighScores::list_scores() { return scores; }

// Return the latest score for this session.
int HighScores::latest_score() { return scores.back(); }

// Return the highest score for this session.
int HighScores::personal_best() {
    return *std::max_element(scores.begin(), scores.end());
}

// Return the top 3 scores for this session in descending order.
std::vector<int> HighScores::top_three() {
    std::vector<int> sorted(scores.size());
    std::partial_sort_copy(scores.begin(), scores.end(), sorted.begin(),
                           sorted.end(), std::greater<>());

    if (scores.size() >= 3) {
        return {sorted.begin(), sorted.begin() + 3};
    }

    return sorted;
}

} // namespace arcade
