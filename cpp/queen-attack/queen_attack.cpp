#include "queen_attack.hpp"

namespace queen_attack {

chess_board::chess_board(position_t white, position_t black)
    : _black(black), _white(white) {
    check_domain_error(_is_valid_position(black));
    check_domain_error(_is_valid_position(white));
    check_domain_error(_is_stacked_position(black, white));
}

bool chess_board::can_attack() const {
    slope_t slope{};

    // running std::cout from a catch usually is a very bad idea
    try {
        std::cout << "_slope() -> [";
        slope = _slope();
        std::cout << slope << "]" << std::endl;
    } catch (std::domain_error &exception) {
        // never thrown for `queens_can_attack_on_same_row`
        std::cout << "exception: [" << exception.what() << "]" << std::endl;
        const std::string dbz{"divide_by_zero"};
        std::cout << "want: [" << dbz << "]" << std::endl;
        return exception.what() != dbz;
    }

    // the signal handler that doesn't run blocks the floating point error
    // and allows us to test for inf value.
    // horizontal or diagonal or vertical attack?
    return slope == 0.0 or slope == 1.0 or std::isinf(slope);
}

position_t chess_board::black() const { return _black; }

position_t chess_board::white() const { return _white; }

// this function
// - returns 0 or 1 for a horizontal (col) or diagonal attack
// - throws divide_by_zero for vertical (row) attack
slope_t chess_board::_slope() const {
    // can't figure out why this never runs for `queens_can_attack_on_same_row`
    auto throw_divide_by_zero = [](int) {
        throw std::domain_error{"divide_by_zero"};
    };

    std::signal(SIGFPE, throw_divide_by_zero);
    const slope_t slope{double(_black.second - _white.second) /
                        double(_black.first - _white.first)};

    return std::abs(slope);
}

result_t chess_board::_is_valid_position(position_t position) {
    result_t result{};

    if (position.first < k_row_min or position.first > k_row_max) {
        result.set_ok(false);
        result.set_error("position row value not in range (" +
                         std::to_string(k_row_min) + "-" +
                         std::to_string(k_row_max) + ")");

        return result;
    }

    if (position.second < k_col_min or position.second > k_col_max) {
        result.set_ok(false);
        result.set_error("position column value not in range (" +
                         std::to_string(k_col_min) + "-" +
                         std::to_string(k_col_max) + ")");

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
