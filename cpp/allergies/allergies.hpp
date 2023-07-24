#if !defined(ALLERGIES_HPP)
#define ALLERGIES_HPP

#include <map>
#include <numeric>
#include <string>
#include <unordered_set>

namespace allergies {

class allergy_test {
  public:
    allergy_test(int score);

    [[nodiscard]] bool is_allergic_to(std::string allergy) const;
    [[nodiscard]] std::unordered_set<std::string> get_allergies() const;

  private:
    std::map<std::string, int> allergies;
    std::unordered_set<std::string> allergic_reactions;
};

} // namespace allergies

#endif // ALLERGIES_HPP
