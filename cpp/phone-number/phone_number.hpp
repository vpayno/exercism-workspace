#if !defined(PHONE_NUMBER_HPP)
#define PHONE_NUMBER_HPP

#include <string>

namespace phone_number {

using phone_number_t = std::string;
using area_code_t = std::string;
using exchange_code_t = std::string;
using subscriber_number_t = std::string;
using error_msg_t = std::string;

const error_msg_t k_error_0001{"incorrect number of digits"};
const error_msg_t k_error_0002{"11 digits must start with 1"};
const error_msg_t k_error_0003{"more than 11 digits"};
const error_msg_t k_error_0004{"letters not permitted"};
const error_msg_t k_error_0005{"punctuations not permitted"};
const error_msg_t k_error_0006{"area code cannot start with zero"};
const error_msg_t k_error_0007{"area code cannot start with one"};
const error_msg_t k_error_0008{"exchange code cannot start with zero"};
const error_msg_t k_error_0009{"exchange code cannot start with one"};

struct phone_number final {
  public:
    phone_number(phone_number_t old_number);
    [[nodiscard]] phone_number_t number() const;
    [[nodiscard]] area_code_t area_code() const;
    [[nodiscard]] exchange_code_t exchange_code() const;
    [[nodiscard]] subscriber_number_t subscriber_number() const;
    explicit operator std::string() const;

  private:
    [[nodiscard]] static bool is_phone_number_valid(phone_number_t number);
    phone_number_t _number;
};

} // namespace phone_number

#endif // PHONE_NUMBER_HPP
