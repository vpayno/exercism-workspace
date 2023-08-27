//! Exercise Url: <https://exercism.org/tracks/rust/exercises/secret-handshake>

#[derive(Debug, Clone, Copy)]
#[repr(u8)]
enum Command {
    Wink = 0b0000_0001,
    DoubleBlink = 0b0000_0010,
    CloseYourEyes = 0b0000_0100,
    Jump = 0b0000_1000,
    Reverse = 0b0001_0000,
    Limit = 0b0010_0000,
}

impl std::fmt::Display for Command {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        match self {
            Command::Wink => write!(f, "wink"),
            Command::DoubleBlink => write!(f, "double blink"),
            Command::CloseYourEyes => write!(f, "close your eyes"),
            Command::Jump => write!(f, "jump"),
            Command::Reverse => write!(f, "reverse"),
            _ => write!(f, ""),
        }
    }
}

/// returns a vector of actions decoded from a number
///
/// Changed the return type from a static str slice to String because it's easier
/// to work with (less you can't return a temporary borrowed value errors).
///
/// Example
///
/// ```rust
/// use secret_handshake::actions;
///
/// let want = vec!["wink", "double blink", "close your eyes", "jump"];
/// let got = actions(15);
///
/// assert_eq!(got, want);
/// ```
pub fn actions(commands: u8) -> Vec<String> {
    let mut steps: Vec<String> = Vec::new();

    if commands == 0 {
        // return steps.clone();
    }

    if commands >= Command::Limit as u8 {
        // return steps.clone();
    }

    if commands & Command::Wink as u8 == Command::Wink as u8 {
        steps.push(Command::Wink.to_string());
    }

    if commands & Command::DoubleBlink as u8 == Command::DoubleBlink as u8 {
        steps.push(Command::DoubleBlink.to_string());
    }

    if commands & Command::CloseYourEyes as u8 == Command::CloseYourEyes as u8 {
        steps.push(Command::CloseYourEyes.to_string());
    }

    if commands & Command::Jump as u8 == Command::Jump as u8 {
        steps.push(Command::Jump.to_string());
    }

    if commands & Command::Reverse as u8 == Command::Reverse as u8 {
        steps.reverse();
    }

    steps.clone()
}
