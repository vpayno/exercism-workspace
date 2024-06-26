#include <algorithm>
#include <string>
#include <vector>

namespace election {

using CadidateName = std::string;
using VoteCount = int;

// The election result struct is already created for you:
struct ElectionResult {
    // Name of the candidate
    CadidateName name{};

    // Number of votes the candidate has
    VoteCount votes{};
};

using ElectionSummary = std::vector<ElectionResult>;

// Task 1: vote_count()
// - takes a reference to an `ElectionResult` as an argument
// - will return the number of votes in the `ElectionResult`
VoteCount vote_count(ElectionResult &result) { return result.votes; }

// Task 2: increment_vote_count()
// - takes a reference to an `ElectionResult` as an argument
// - and a number of votes (VoteCount)
// - increments the `ElectionResult` by that number of votes
void increment_vote_count(ElectionResult &result, VoteCount count) {
    result.votes += count;
}

// Task 3: determine_result()
// - receives the reference to a final_count
// - returns a reference to the `ElectionResult` of the new president
// - it also changes the name of the winner by prefixing it with "President"
// - the final count is given in the form of a `reference` to
// `ElectionSummary`, a vector with `ElectionResults` of all the
// participating candidates
ElectionResult &determine_result(ElectionSummary &final_count) {
    int index{0};
    int counter{0};
    VoteCount highest_score{0};

    // index is a reference so we can access the "loop" value after
    // std::transform runs
    auto find_winner_op = [counter, &index, highest_score](
                              ElectionResult result) mutable -> ElectionResult {
        if (result.votes > highest_score) {
            highest_score = result.votes;
            index = counter;
        }

        counter += 1;

        return result;
    };

    std::transform(final_count.begin(), final_count.end(), final_count.begin(),
                   find_winner_op);

    final_count.at(index).name = "President " + final_count.at(index).name;

    return final_count.at(index);
}

} // namespace election
