#include "robot_name.hpp"
#include <algorithm>
#include <cstdlib>

namespace robot_name {

// NOLINTNEXTLINE(cppcoreguidelines-avoid-non-const-global-variables)
name_history_t g_name_history{};

robot::robot() { _name = _new_name(); }

robot_name_t robot::name() const { return _name; }

void robot::reset() { _name = _new_name(); }

robot_name_t robot::_new_name_candidate() {
    robot_name_t name{};

    name += robot::_random_letter();
    name += robot::_random_letter();
    name += robot::_random_number();
    name += robot::_random_number();
    name += robot::_random_number();

    return name;
}

robot_name_t robot::_new_name() {
    robot_name_t candidate{_new_name_candidate()};

    while (std::find(g_name_history.begin(), g_name_history.end(), candidate) !=
           g_name_history.end()) {
        candidate = _new_name_candidate();
    }

    g_name_history.emplace(candidate);

    return candidate;
}

char robot::_random_letter() { return (char)('A' + (std::rand() % 26)); }

char robot::_random_number() { return (char)('0' + (std::rand() % 10)); }

} // namespace robot_name
