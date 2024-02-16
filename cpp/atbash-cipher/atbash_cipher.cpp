#include "atbash_cipher.hpp"
#include <cctype>
#include <string>

namespace atbash_cipher {

std::string encode(std::string message) {
    std::string encoded;

    if (message.length() == 0) {
        return encoded;
    }

    int index{0};

    for (const char rune : message) {
        if ((bool)isalnum(rune)) {
            if (index != 0 and index % 5 == 0) {
                encoded += ' ';
            };

            encoded += shift_char(rune);
            index += 1;
        }
    }

    return encoded;
}

std::string decode(std::string secret) {
    std::string plain;

    if (secret.length() == 0) {
        return plain;
    }

    for (const char rune : secret) {
        if ((bool)isalnum(rune)) {
            plain += shift_char(rune);
        }
    }

    return plain;
}

char shift_char(char plain) {
    char encoded{0};

    if ((bool)isdigit(plain)) {
        return plain;
    }

    const char lower = (char)tolower(plain);

    const int offset{26 - 1};

    encoded = (char)(offset - (lower - 'a') + 'a');

    return encoded;
}

} // namespace atbash_cipher
