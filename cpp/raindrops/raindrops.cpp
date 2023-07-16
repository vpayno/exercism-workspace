#include "raindrops.h"

namespace raindrops {

std::string convert(int num) {
    std::string sounds;

    if (num % 3 == 0) {
        sounds += "Pling";
    }

    if (num % 5 == 0) {
        sounds += "Plang";
    }

    if (num % 7 == 0) {
        sounds += "Plong";
    }

    if (sounds.empty()) {
        sounds = std::to_string(num);
    }

    return sounds;
}
} // namespace raindrops
