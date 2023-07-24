#pragma once

#include <algorithm>
#include <array>
#include <utility>
#include <vector>

namespace arcade {

class HighScores {
  private:
    std::vector<int> scores;

  public:
    HighScores(std::vector<int> scores) : scores(std::move(scores)){};

    std::vector<int> list_scores();

    int latest_score();

    int personal_best();

    std::vector<int> top_three();
};

} // namespace arcade
