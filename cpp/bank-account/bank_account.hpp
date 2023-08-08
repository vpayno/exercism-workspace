#if !defined(BANK_ACCOUNT_HPP)
#define BANK_ACCOUNT_HPP

#include <mutex>
#include <stdexcept>
#include <string>

namespace Bankaccount {

using cash_t = int;
using message_t = std::string;
using lock_guard_t = std::lock_guard<std::mutex>;

struct Bankaccount {
  public:
    Bankaccount() = default;

    void open();
    void close();
    void deposit(cash_t amount);
    void withdraw(cash_t amount);

    [[nodiscard]] cash_t balance();

  private:
    cash_t _balance{0};
    bool _open{false};
    std::mutex _mutex{};
};

void check_runtime_error(bool condition, message_t message);

} // namespace Bankaccount

#endif // BANK_ACCOUNT_HPP
