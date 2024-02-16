#include "robot_simulator.hpp"
#include <utility>

namespace robot_simulator {

Robot::Robot() = default;

Robot::Robot(coordinate_t position, Bearing bearing)
    : _bearing{bearing}, _position{std::move(position)} {}

Bearing Robot::get_bearing() const { return _bearing; }

coordinate_t Robot::get_position() const { return _position; }

void Robot::advance() {
    switch (_bearing) {
    case Bearing::NORTH:
        _position.second += 1;
        break;
    case Bearing::SOUTH:
        _position.second -= 1;
        break;
    case Bearing::EAST:
        _position.first += 1;
        break;
    case Bearing::WEST:
        _position.first -= 1;
        break;
    }
}

void Robot::turn_right() {
    switch (_bearing) {
    case Bearing::NORTH:
        _bearing = Bearing::EAST;
        break;
    case Bearing::SOUTH:
        _bearing = Bearing::WEST;
        break;
    case Bearing::EAST:
        _bearing = Bearing::SOUTH;
        break;
    case Bearing::WEST:
        _bearing = Bearing::NORTH;
        break;
    }
}

void Robot::turn_left() {
    switch (_bearing) {
    case Bearing::NORTH:
        _bearing = Bearing::WEST;
        break;
    case Bearing::SOUTH:
        _bearing = Bearing::EAST;
        break;
    case Bearing::EAST:
        _bearing = Bearing::NORTH;
        break;
    case Bearing::WEST:
        _bearing = Bearing::SOUTH;
        break;
    }
}

void Robot::execute_sequence(steps_t steps) {
    for (auto step : steps) {
        const Action action{step};

        switch (action) {
        case Action::ADVANCE:
            advance();
            break;
        case Action::RIGHT:
            turn_right();
            break;
        case Action::LEFT:
            turn_left();
            break;
        }
    }
}

} // namespace robot_simulator
