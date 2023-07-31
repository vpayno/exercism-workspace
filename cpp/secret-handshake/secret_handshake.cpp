#include "secret_handshake.h"

namespace secret_handshake {

steps_t commands(commands_t commands) {
    steps_t steps{};

    if (commands == 0) {
        return steps;
    }

    if (commands >= (int)Commands::LIMIT) {
        return steps;
    }

    if ((commands & (int)Commands::Wink) == (int)Commands::Wink) {
        steps.emplace_back(k_command_to_step.at(Commands::Wink));
    }

    if ((commands & (int)Commands::DoubleBlink) == (int)Commands::DoubleBlink) {
        steps.emplace_back(k_command_to_step.at(Commands::DoubleBlink));
    }

    if ((commands & (int)Commands::CloseYourEyes) ==
        (int)Commands::CloseYourEyes) {
        steps.emplace_back(k_command_to_step.at(Commands::CloseYourEyes));
    }

    if ((commands & (int)Commands::Jump) == (int)Commands::Jump) {
        steps.emplace_back(k_command_to_step.at(Commands::Jump));
    }

    if ((commands & (int)Commands::Reverse) == (int)Commands::Reverse) {
        std::reverse(steps.begin(), steps.end());
    }

    return steps;
}

} // namespace secret_handshake
