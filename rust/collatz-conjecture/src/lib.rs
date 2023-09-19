pub fn collatz(start: u64) -> Option<u64> {
    if start == 0 {
        return None;
    }

    let mut count: u64 = 0;

    if start == 1 {
        return Some(count);
    }

    let mut num: u128 = start as u128;

    while num > 1 {
        /* Not sure why limitation in the tests this was necessary since we still need u128 for this to work and we do get a value.
         * thread 'one_million' panicked at 'assertion failed: `(left == right)`
         *   left: `Some(152)`,
         *  right: `None`', tests/collatz-conjecture.rs:20:5
         * note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
         *
         * ---- sixteen stdout ----
         * thread 'sixteen' panicked at 'assertion failed: `(left == right)`
         *   left: `Some(4)`,
         *  right: `None`', tests/collatz-conjecture.rs:10:5
         *
         * ---- twelve stdout ----
         * thread 'twelve' panicked at 'assertion failed: `(left == right)`
         *   left: `Some(9)`,
         *  right: `None`', tests/collatz-conjecture.rs:15:5
         */
        if num >= u64::MAX as u128 {
            return None;
        }

        count += 1;

        if num % 2 == 0 {
            num /= 2;
        } else {
            num = num * 3 + 1;
        }
    }

    Some(count)
}
