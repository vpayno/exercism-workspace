#include "queen_attack.h"

namespace queen_attack {

chess_board::chess_board(position_t white, position_t black)
    : _black(black), _white(white) {
    check_domain_error(_is_valid_position(black));
    check_domain_error(_is_valid_position(white));
    check_domain_error(_is_stacked_position(black, white));
}

bool chess_board::can_attack() const {
    // vertical attack? (divide by zero for slope()
    if (_white.first == _black.first) {
        return true;
    }

    // this is tested second since both pieces on the same row has an
    // indeterminate slope (divide by zero error). diagonal or horizontal attack
    const slope_t slope{_slope()};

    return slope == 0.0 or slope == 1.0;
}

position_t chess_board::black() const { return _black; }

position_t chess_board::white() const { return _white; }

// this function takes care of horizontal or diagonal attacks
slope_t chess_board::_slope() const {
    const slope_t slope{double(_black.second - _white.second) /
                        double(_black.first - _white.first)};

    return std::abs(slope);
}

result_t chess_board::_is_valid_position(position_t position) {
    result_t result{};

    if (position.first < k_row_min or position.first > k_row_max) {
        result.set_ok(false);
        result.set_error("position column value not in range (1-8)");

        return result;
    }

    if (position.second < k_col_min or position.second > k_col_max) {
        result.set_ok(false);
        result.set_error("position row value not in range (1-8)");

        return result;
    }

    return result;
}

result_t chess_board::_is_stacked_position(position_t pos1, position_t pos2) {
    result_t result{};

    if (pos1 == pos2) {
        result.set_ok(false);
        result.set_error("both positions occupy the same square");

        return result;
    }

    return result;
}

void check_domain_error(result_t result) {
    if (!result.ok()) {
        throw std::domain_error{result.error()};
    }
}

} // namespace queen_attack
