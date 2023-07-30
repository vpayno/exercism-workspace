#pragma once

#include <algorithm>
#include <array>
#include <utility>
#include <vector>

namespace arcade {

using score_t = int;
using scores_t = std::vector<score_t>;

class HighScores {
  public:
    HighScores(scores_t _scores) : _scores(std::move(_scores)){};

    [[nodiscard]] scores_t list_scores() const;

    [[nodiscard]] score_t latest_score() const;

    // tests are calling functions and not capturing results :)
    // NOLINTNEXTLINE(modernize-use-nodiscard)
    score_t personal_best() const;

    // tests are calling functions and not capturing results :)
    // NOLINTNEXTLINE(modernize-use-nodiscard)
    scores_t top_three() const;

  private:
    scores_t _scores;
};

} // namespace arcade
