#include <algorithm>
#include <array>
#include <cmath>
#include <ios>
#include <numeric>
#include <string>
#include <string_view>
#include <vector>

using score_t = int;
using scores_t = std::vector<int>;
using scores_input_t = std::vector<double>;
using student_names_t = std::vector<std::string>;

// Round down all provided student scores.
scores_t round_down_scores(scores_input_t student_scores) {
    scores_t rounded{};
    rounded.resize(student_scores.size());

    auto unary_op = [](score_t score) { return std::lround(score); };

    std::transform(student_scores.begin(), student_scores.end(),
                   rounded.begin(), unary_op);

    return rounded;
}

// Count the number of failing students out of the group provided.
int count_failed_students(scores_t student_scores) {
    int count{0};

    auto unary_op = [](score_t score) { return score <= 40; };

    count = (int)std::count_if(student_scores.begin(), student_scores.end(),
                               unary_op);

    return count;
}

// Determine how many of the provided student scores were 'the best' based on
// the provided threshold.
scores_t above_threshold(scores_t student_scores, score_t threshold) {
    scores_t result{};

    // this is a closure that captures threshold
    auto unary_op = [threshold](score_t score) { return score >= threshold; };

    std::copy_if(student_scores.begin(), student_scores.end(),
                 std::back_inserter(result), unary_op);

    return result;
}

// Create a list of grade thresholds based on the provided highest grade.
std::array<score_t, 4> letter_grades(score_t highest_score) {
    const score_t offset =
        14 - (score_t)std::lround((double)((100 - highest_score) / 4.0));
    const score_t lower = 41;

    score_t grade = lower;

    std::array<score_t, 4> grades{grade, 0, 0, 0};

    bool first = true;

    for (int &iter : grades) {
        if (first) {
            first = false;
            continue;
        }

        grade += offset + 1;
        iter = grade;
    }

    return grades;
}

// Organize the student's rank, name, and grade information in ascending order.
std::vector<std::string>
student_ranking(scores_t student_scores,
                std::vector<std::string> student_names) {
    std::vector<std::string> rankings{};

    if (student_scores.empty() or student_names.empty()) {
        return rankings;
    }

    if (student_scores.size() != student_names.size()) {
        return rankings;
    }

    std::vector<std::string> str_scores{};

    auto itos_op = [](const score_t score) { return std::to_string(score); };

    std::transform(student_scores.begin(), student_scores.end(),
                   std::back_inserter(str_scores), itos_op);

    int rank{1};

    auto binary_op = [rank](const std::string name,
                            const std::string score) mutable -> std::string {
        // return "rank. name: score"
        return std::to_string(rank++) + ". " + name + ": " + score;
    };

    std::transform(student_names.begin(), student_names.end(),
                   str_scores.begin(), std::back_inserter(rankings), binary_op);

    return rankings;
}

// Create a string that contains the name of the first student to make a perfect
// score on the exam.
std::string perfect_score(scores_t student_scores,
                          std::vector<std::string> student_names) {
    std::string perfect_student;

    if (student_scores.empty() or student_names.empty()) {
        return perfect_student;
    }

    if (student_scores.size() != student_names.size()) {
        return perfect_student;
    }

    auto it_scores = student_scores.begin();
    auto it_names = student_names.begin();

    while (it_scores != student_scores.end() ||
           it_names != student_names.end()) {

        if (*it_scores == 100) {
            return *it_names;
        }

        if (it_scores != student_scores.end()) {
            it_scores++;
        }

        if (it_names != student_names.end()) {
            it_names++;
        }
    }

    return perfect_student;
}
