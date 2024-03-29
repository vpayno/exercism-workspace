namespace hellmath {

/* I'm not seeing how bitmask enums would make things more readable with these
 * switch statements.
 *
 * The if blocks are definitely more readable than nested switches.
 *
 * Am I the troll? Is this exercise trolling me?
 */

// Task 1 - Define an `AccountStatus` enumeration to represent the four
// account types: `troll`, `guest`, `user`, and `mod`.
enum class AccountStatus {
    troll,
    guest,
    user,
    mod,
};

// Task 1 - Define an `Action` enumeration to represent the three
// permission types: `read`, `write`, and `remove`.
enum class Action {
    read,
    write,
    remove,
};

// Task 2 - Implement the `display_post` function, that gets two arguments
// of `AccountStatus` and returns a `bool`. The first argument is the status of
// the poster, the second one is the status of the viewer.
// poster(user) - visible to everyone
// poster(trol) - not visible to everyone
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
bool display_post(AccountStatus poster, AccountStatus viewer) {
    switch (poster) {
    case AccountStatus::troll:
        switch (viewer) {
        case AccountStatus::troll:
            return true;
        default:
            return false;
        }
        break;
    default:
        return true;
    }
}

// Task 3 - Implement the `permission_check` function, that takes an
// `Action` as a first argument and an `AccountStatus` to check against. It
// should return a `bool`.
// guest - read only
// troll - read, write
// user - read, write
// mod - read, write, remove
// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
bool permission_check(Action action, AccountStatus viewer) {
    switch (action) {
    case Action::read:
        return true;
    case Action::remove:
        switch (viewer) {
        case AccountStatus::mod:
            return true;
        default:
            return false;
        }
        break;
    case Action::write:
        switch (viewer) {
        case AccountStatus::guest:
            return false;
        default:
            return true;
        }
        break;
    default:
        return false;
    }
}

// Task 4 - Implement the `valid_player_combination` function that
// checks if two players can join the same game. The function has two parameters
// of type `AccountStatus` and returns a `bool`.
// player1 - not guest
// trolls can only play with trolls
// users can play with users and mods
// mods can play with users and mods
// guests can't play
bool valid_player_combination(AccountStatus player1, AccountStatus player2) {
    if (player1 == AccountStatus::guest or player2 == AccountStatus::guest) {
        return false;
    }

    if (player1 == AccountStatus::troll and player2 == AccountStatus::troll) {
        return true;
    }

    if (player1 == AccountStatus::troll or player2 == AccountStatus::troll) {
        return false;
    }

    return true;
}

// Task 5 - Implement the `has_priority` function that takes two
// `AccountStatus` arguments and returns `true`, if and only if the first
// account has a strictly higher priority than the second.
// highest > lowest
// mod > user > guest > troll
// two of the same is false
bool has_priority(AccountStatus player1, AccountStatus player2) {
    return player1 > player2;
}

} // namespace hellmath
