/// various log levels
// #[derive(Clone, PartialEq, Eq, Debug)]
#[derive(Debug)]
pub enum LogLevel {
    Info,
    Warning,
    Error,
    Debug,
}

/// primary function for emitting logs
pub fn log(level: LogLevel, message: &str) -> String {
    // Use the Debug trait to convert the enum to string.
    let level_str: String = format!("{level:?}").to_uppercase();

    // Put the log line together.
    let log_line: String = format!("[{level_str}]: {message}");

    // Return the log line.
    log_line
}

pub fn info(message: &str) -> String {
    log(LogLevel::Info, message)
}

pub fn warn(message: &str) -> String {
    log(LogLevel::Warning, message)
}

pub fn error(message: &str) -> String {
    log(LogLevel::Error, message)
}

pub fn debug(message: &str) -> String {
    log(LogLevel::Debug, message)
}
