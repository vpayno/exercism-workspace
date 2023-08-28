//! Exercise Url: <https://exercism.org/tracks/rust/exercises/binary-search>

/// finds the key in a sorted array
///
/// Example
///
/// ```rust
/// use binary_search::find;
///
/// let mut want: Option<usize> = None;
/// let mut got: Option<usize> = None;
///
/// want = Some(3);
/// got = find(&[0,2,4,6,8,10], 6);
/// assert_eq!(got, want);
///
/// want = None;
/// got = find(&[0,2,4,6,8,10], 5);
/// assert_eq!(got, want);
/// ```
pub fn find(array: &[i32], key: i32) -> Option<usize> {
    let not_found = None;

    if array.is_empty() {
        return not_found;
    }

    let mut low: usize = 0;
    let mut high: usize = array.len() - 1;

    if array[low] > key || array[high] < key {
        return not_found;
    }

    let mut mid: usize = (high + low) / 2;
    let mut mid_value: i32 = array[mid];

    while mid_value != key {
        if mid_value > key {
            high = mid - 1;
        } else {
            low = mid + 1;
        }

        if low > high {
            return not_found;
        }

        mid = (high + low) / 2;
        mid_value = array[mid];
    }

    Some(mid)
}
