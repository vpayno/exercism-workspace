#include "high_scores.hpp"

#include <algorithm>
#include <functional>

namespace arcade {

// Return all scores for this session.
scores_t HighScores::list_scores() const { return _scores; }

// Return the latest score for this session.
score_t HighScores::latest_score() const { return _scores.back(); }

// Return the highest score for this session.
score_t HighScores::personal_best() const {
    return *std::max_element(_scores.begin(), _scores.end());
}

// Return the top 3 scores for this session in descending order.
scores_t HighScores::top_three() const {
    scores_t sorted_scores(_scores.size());

    std::partial_sort_copy(_scores.begin(), _scores.end(),
                           sorted_scores.begin(), sorted_scores.end(),
                           std::greater<>());

    if (_scores.size() >= 3) {
        return {sorted_scores.begin(), sorted_scores.begin() + 3};
    }

    return sorted_scores;
}

} // namespace arcade
