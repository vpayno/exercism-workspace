#include "allergies.hpp"

namespace allergies {

bool allergy_test::is_allergic_to(std::string allergy) const {
    // count seems to be the easiest choice for a "is in set" check
    return allergic_reactions.count(allergy) > 0;
}

std::unordered_set<std::string> allergy_test::get_allergies() const {
    return allergic_reactions;
}

allergy_test::allergy_test(int score) {
    allergies = {
        {"eggs", 1},         {"peanuts", 2},   {"shellfish", 4},
        {"strawberries", 8}, {"tomatoes", 16}, {"chocolate", 32},
        {"pollen", 64},      {"cats", 128},
    };

    /* Example of what a sane soluition would have looked like.
    for(auto &allergy : allergies) {
        if ((allergy.second & score) != 0) {
            allergic_reactions.emplace(allergy.first);
        }
    }
    */

    /* I've been enjoing using std map/reduce functions over simpler for loops
       so here's today's nightmare.

       Using accumulate to sum nothing while binary_op inserts to the captured
       set.

       This would have been easier with std::copy_if if the set wasn't comprised
       of std::pair elements since the target only has strings in it.

       The std::copy_if unary_op only returns a boolean so we can't tell it to
       only copy pair.first instead of the whole pair.
       */

    auto binary_op = [score, set = &allergic_reactions](
                         int, std::pair<std::string, int> allergy) {
        if ((allergy.second & score) != 0) {
            set->emplace(allergy.first);
        }

        return 0;
    };

    std::accumulate(allergies.begin(), allergies.end(), 0, binary_op);
}

} // namespace allergies
