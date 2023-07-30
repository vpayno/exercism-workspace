namespace targets {

using HealthScore = int;
// coordinates should be a struct or class

class Alien {
  public:
    // NOLINTNEXTLINE(cppcoreguidelines-non-private-member-variables-in-classes,misc-non-private-member-variables-in-classes)
    int x_coordinate{0};
    // NOLINTNEXTLINE(cppcoreguidelines-non-private-member-variables-in-classes,misc-non-private-member-variables-in-classes)
    int y_coordinate{0};

    Alien(int x_new, int y_new) : x_coordinate(x_new), y_coordinate(y_new) {}

    [[nodiscard]] HealthScore get_health() const { return health; }

    [[nodiscard]] bool is_alive() const { return health > 0; }

    [[nodiscard]] bool collision_detection(Alien other) const {
        const bool x_collision = x_coordinate == other.x_coordinate;
        const bool y_collision = y_coordinate == other.y_coordinate;

        return x_collision and y_collision;
    }

    // They insist it must return a value but don't always use it in the tests.
    // NOLINTNEXTLINE(modernize-use-nodiscard)
    bool hit() {
        if (!shield_up) {
            if (is_alive()) {
                health -= 1;
            }
        }

        return !shield_up;
    }

    // They insist it must return a value but don't always use it in the tests.
    // NOLINTNEXTLINE(modernize-use-nodiscard)
    bool teleport(int new_x, int new_y) {
        if (!teleport_blocked) {
            x_coordinate = new_x;
            y_coordinate = new_y;
        }

        return !teleport_blocked;
    }

  private:
    HealthScore health{3};
    bool shield_up{false};
    bool teleport_blocked{false};
};

} // namespace targets
