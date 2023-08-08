#if !defined(CRYPTO_SQUARE_HPP)
#define CRYPTO_SQUARE_HPP

#include <algorithm>
#include <regex>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

namespace crypto_square {

using letter_t = char;
using plain_text_t = std::string;
using plain_segments_t = std::vector<plain_text_t>;
using cipher_text_t = std::string;
using cipher_buffer_t = std::stringstream;

struct cipher {
  public:
    cipher() = delete;
    cipher(plain_text_t plain_text);

    [[nodiscard]] plain_text_t normalize_plain_text() const;
    [[nodiscard]] plain_segments_t plain_text_segments() const;
    [[nodiscard]] cipher_text_t cipher_text() const;
    [[nodiscard]] cipher_text_t normalized_cipher_text() const;

  private:
    plain_text_t _plain_text{};
};

} // namespace crypto_square

#endif // CRYPTO_SQUARE_HPP
