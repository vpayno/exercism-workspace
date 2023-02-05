/// Create an empty vector
pub fn create_empty() -> Vec<u8> {
    Vec::new()
}

/// Create a buffer of `count` zeroes.
///
/// Applications often use buffers when serializing data to send over the network.
pub fn create_buffer(count: usize) -> Vec<u8> {
    let buffer: Vec<u8> = vec![0; count];

    buffer
}

/// Create a vector containing the first five elements of the Fibonacci sequence.
///
/// Fibonacci's sequence is the list of numbers where the next number is a sum of the previous two.
/// Its first five elements are `1, 1, 2, 3, 5`.
pub fn fibonacci() -> Vec<u8> {
    // Didn't get the impression we actually needed to bother calculating the numbers.
    // Using create_buffer() and .push() resulted in larger buffers and it would fail the test.
    let buffer: Vec<u8> = vec![1, 1, 2, 3, 5];

    // Return buffer.
    buffer
}
