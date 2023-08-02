#if !defined(ROBOT_SIMULATOR_H)
#define ROBOT_SIMULATOR_H

#include <string>
#include <utility>

namespace robot_simulator {

enum class Bearing {
    NORTH,
    SOUTH,
    EAST,
    WEST,
};

enum class Action {
    ADVANCE = 'A',
    RIGHT = 'R',
    LEFT = 'L',
};

using x_axis_t = int;
using y_axis_t = int;
using coordinate_t = std::pair<x_axis_t, y_axis_t>;
using steps_t = std::string;

struct Robot final {
  public:
    Robot();
    Robot(coordinate_t position, Bearing bearing);

    [[nodiscard]] Bearing get_bearing() const;
    [[nodiscard]] coordinate_t get_position() const;

    void advance();
    void turn_right();
    void turn_left();

    void execute_sequence(steps_t steps);

  private:
    Bearing _bearing{Bearing::NORTH};
    coordinate_t _position{0, 0};
};

} // namespace robot_simulator

#endif // ROBOT_SIMULATOR_H
