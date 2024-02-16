#include <utility>
#if !defined(SECRET_HANDSHAKE_HPP)
#define SECRET_HANDSHAKE_HPP

#include <map>
#include <string>
#include <vector>

namespace secret_handshake {

enum class Commands {
    Wink = 1,
    DoubleBlink = 2,
    CloseYourEyes = 4,
    Jump = 8,
    Reverse = 16,
    LIMIT = 32,
};

using commands_t = int;
using steps_t = std::vector<std::string>;
using step_t = std::string;
using command_to_step_t = std::map<Commands, step_t>;

const command_to_step_t k_command_to_step = {
    std::make_pair(Commands::Wink, "wink"),
    std::make_pair(Commands::DoubleBlink, "double blink"),
    std::make_pair(Commands::CloseYourEyes, "close your eyes"),
    std::make_pair(Commands::Jump, "jump"),
};

steps_t commands(commands_t commands);

} // namespace secret_handshake

#endif // SECRET_HANDSHAKE_HPP
