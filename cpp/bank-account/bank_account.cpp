#include "bank_account.hpp"
#include <stdexcept>

namespace Bankaccount {

void check_runtime_error(bool condition, message_t message) {
    if (condition) {
        throw std::runtime_error{message};
    }
}

void Bankaccount::open() {
    check_runtime_error(_open, "account already opened");

    const lock_guard_t lock(_mutex);

    _open = true;
}

void Bankaccount::close() {
    check_runtime_error(!_open, "account already closed");

    const lock_guard_t lock(_mutex);

    _open = false;
    _balance = 0;
}

void Bankaccount::deposit(cash_t amount) {
    check_runtime_error(!_open, "account already closed");
    check_runtime_error(amount < 0, "can't deposit a negative amount");

    const lock_guard_t lock(_mutex);

    _balance += amount;
}

void Bankaccount::withdraw(cash_t amount) {
    check_runtime_error(!_open, "account already closed");
    check_runtime_error(amount < 0, "can't withdraw a negative amount");
    check_runtime_error(_balance < amount,
                        "can't widthraw more than what's deposited");

    const lock_guard_t lock(_mutex);

    _balance -= amount;
}

cash_t Bankaccount::balance() {
    check_runtime_error(!_open, "account already closed");

    const lock_guard_t lock(_mutex);

    return _balance;
}

} // namespace Bankaccount
