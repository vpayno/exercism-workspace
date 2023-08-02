#if !defined(ROBOT_NAME_H)
#define ROBOT_NAME_H

#include <algorithm>
#include <set>
#include <string>

namespace robot_name {

using robot_name_t = std::string;
using name_history_t = std::set<robot_name_t>;

struct robot final {
  public:
    robot();

    [[nodiscard]] robot_name_t name() const;

    void reset();

  private:
    [[nodiscard]] static char _random_letter();
    [[nodiscard]] static char _random_number();
    [[nodiscard]] static robot_name_t _new_name();
    [[nodiscard]] static robot_name_t _new_name_candidate();

    robot_name_t _name;
};

} // namespace robot_name

#endif // ROBOT_NAME_H
