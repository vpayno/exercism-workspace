#include "vehicle_purchase.hpp"
#include <cmath>
#include <string>

namespace vehicle_purchase {

// needs_license determines whether a license is needed to drive a type of
// vehicle. Only "car" and "truck" require a license.
bool needs_license(const std::string kind) {
    return kind == "truck" || kind == "car";
}

// choose_vehicle recommends a vehicle for selection. It always recommends the
// vehicle that comes first in lexicographical order.
std::string choose_vehicle(const std::string option1,
                           const std::string option2) {
    std::string choice;
    const std::string comment = " is clearly the better choice.";

    if (option1 <= option2) {
        choice = option1;
    } else {
        choice = option2;
    }

    return choice + comment;
}

// calculate_resell_price calculates how much a vehicle can resell for at a
// certain age.
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
double calculate_resell_price(const double original_price, const double age) {
    double offset{0.50};

    if (age < 3) {
        offset = 0.80;
    } else if (age < 10) {
        offset = 0.70;
    }

    return std::ceil(original_price * offset);
}

} // namespace vehicle_purchase
