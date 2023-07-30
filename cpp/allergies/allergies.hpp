#if !defined(ALLERGIES_HPP)
#define ALLERGIES_HPP

#include <map>
#include <numeric>
#include <string>
#include <unordered_set>

namespace allergies {

using AllergyScore = int;
using AllergyName = std::string;
using PatientAllergies = std::unordered_set<AllergyName>;

class allergy_test {
  public:
    allergy_test(AllergyScore score);

    [[nodiscard]] bool is_allergic_to(AllergyName allergy) const;
    [[nodiscard]] PatientAllergies get_allergies() const;

  private:
    std::map<AllergyName, AllergyScore> allergies;
    PatientAllergies allergic_reactions;
};

} // namespace allergies

#endif // ALLERGIES_HPP
