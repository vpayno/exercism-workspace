use std::collections::HashSet;

/// Finds all the possible Pythagorean triplets for the given perimeter of a triangle.
///
/// Example
/// ```rust
/// use pythagorean_triplet::*;
/// use std::collections::HashSet;
///
/// let perimeter: u32 = 12;
///
/// let want: HashSet<[u32; 3]> = vec![[3u32, 4, 5]].into_iter().collect();
/// let got: HashSet<[u32; 3]> = find(perimeter);
///
/// assert_eq!(got, want);
/// ```
pub fn find(perimeter: u32) -> HashSet<[u32; 3]> {
    let mut triplets: HashSet<[u32; 3]> = HashSet::new();

    if perimeter == 0 {
        return triplets;
    }

    (2..perimeter / 2).for_each(|b| {
        (1..=b).for_each(|a| {
            let c: u32 = perimeter - a - b;

            if a.pow(2) + b.pow(2) == c.pow(2) {
                triplets.insert([a, b, c]);
            }
        });
    });

    triplets
}
