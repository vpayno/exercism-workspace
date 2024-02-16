#if !defined(ATBASH_CIPHER_HPP)
#define ATBASH_CIPHER_HPP

#include <string>

namespace atbash_cipher {

std::string encode(std::string message);
std::string decode(std::string secret);

char shift_char(char plain);

} // namespace atbash_cipher

#endif // ATBASH_CIPHER_HPP
