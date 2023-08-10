#if !defined(QUEEN_ATTACK_H)
#define QUEEN_ATTACK_H

#include <stdexcept>
#include <string>

namespace queen_attack {

using row_t = int;
using col_t = int;
using position_t = std::pair<col_t, row_t>;
using message_t = std::string;
using slope_t = double;

const row_t k_row_min{0};
const row_t k_row_max{7};
const col_t k_col_min{0};
const col_t k_col_max{7};

struct result_t {
  public:
    result_t() = default;

    [[nodiscard]] bool ok() const { return _ok; }
    [[nodiscard]] message_t error() const { return _error; }

    void set_ok(bool result) { _ok = result; };
    void set_error(message_t message) { _error = message; };

  private:
    bool _ok{true};
    message_t _error{};
};

void check_domain_error(result_t result);

struct chess_board {
  public:
    chess_board() = delete;
    chess_board(position_t white, position_t black);

    [[nodiscard]] bool can_attack() const;

    [[nodiscard]] position_t black() const;
    [[nodiscard]] position_t white() const;

  private:
    position_t _black;
    position_t _white;

    [[nodiscard]] slope_t _slope() const;

    [[nodiscard]] static result_t _is_valid_position(position_t position);
    [[nodiscard]] static result_t _is_stacked_position(position_t pos1,
                                                       position_t pos2);
};

} // namespace queen_attack

#endif // QUEEN_ATTACK_H
