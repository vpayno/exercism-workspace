#include "crypto_square.hpp"
#include <algorithm>
#include <cctype>
#include <cstddef>
#include <functional>
#include <iterator>
#include <regex>
#include <string>
#include <utility>

namespace crypto_square {

cipher::cipher(plain_text_t plain_text) : _plain_text(std::move(plain_text)) {}

plain_text_t cipher::normalize_plain_text() const {
    plain_text_t normalized{};

    if (_plain_text.empty()) {
        return normalized;
    }

    auto alphanum_op = [](letter_t rune) { return (bool)isalnum(rune); };

    std::copy_if(_plain_text.begin(), _plain_text.end(),
                 std::back_inserter(normalized), alphanum_op);

    auto lc_op = [](letter_t rune) { return (letter_t)tolower(rune); };

    std::transform(normalized.begin(), normalized.end(), normalized.begin(),
                   lc_op);

    return normalized;
}

plain_segments_t cipher::plain_text_segments() const {
    plain_segments_t segments{};

    if (_plain_text.empty()) {
        return segments;
    }

    plain_text_t normalized = normalize_plain_text();

    size_t c{0}; // NOLINT(readability-identifier-length)
    size_t r{0}; // NOLINT(readability-identifier-length)

    for (size_t i = 1; c == 0; i++) {
        for (size_t j = 1; j <= i; j++) {
            if ((i * j) >= normalized.length()) {
                if ((i - j) <= 1) {
                    c = i;
                    r = j;

                    break;
                }
            }
        }
    }

    const size_t new_length = c * r;
    normalized.resize(new_length, ' ');

    const std::string re_segment_str{"[ a-z]{" + std::to_string(c) + "}"};
    const std::regex re_segment_exp(re_segment_str,
                                    std::regex_constants::egrep);
    auto segments_begin = std::sregex_iterator(
        normalized.begin(), normalized.end(), re_segment_exp);
    auto segments_end = std::sregex_iterator();

    for (auto iter = segments_begin; iter != segments_end; iter++) {
        auto re_match = *iter;
        std::string segment_str = re_match[0];

        segment_str.erase(std::remove_if(segment_str.begin(), segment_str.end(),
                                         std::function(::isspace)),
                          segment_str.end());
        segments.emplace_back(segment_str);
    }

    return segments;
}

cipher_text_t cipher::cipher_text() const {
    cipher_buffer_t cipher{};
    plain_segments_t plain_segments{plain_text_segments()};

    if (plain_segments.empty()) {
        return cipher.str();
    }

    const size_t limit = plain_segments.front().length();

    for (size_t i = 0; i < limit; i++) {
        for (auto &segment : plain_segments) {
            if (segment[i] != 0) {
                cipher << segment[i];
            }
        }
    }

    return cipher.str();
}

cipher_text_t cipher::normalized_cipher_text() const {
    cipher_buffer_t cipher;
    plain_segments_t plain_segments{plain_text_segments()};

    if (plain_segments.empty()) {
        return cipher.str();
    }

    const size_t limit = plain_segments.front().length();

    for (size_t i = 0; i < limit; i++) {
        cipher_text_t pad{" "};

        for (auto &segment : plain_segments) {
            if (segment[i] != 0) {
                cipher << segment[i];
            } else {
                pad += " ";
            }
        }

        cipher << pad;
    }

    cipher_text_t normalized_cipher{cipher.str()};

    normalized_cipher.resize(normalized_cipher.length() - 1);

    return normalized_cipher;
}

} // namespace crypto_square
