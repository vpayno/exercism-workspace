pub trait Zero {
    const ZERO: Self;
}

impl Zero for i32 {
    const ZERO: Self = 0;
}

impl Zero for i64 {
    const ZERO: Self = 0;
}

impl Zero for i128 {
    const ZERO: Self = 0;
}

impl Zero for u32 {
    const ZERO: Self = 0;
}

impl Zero for u64 {
    const ZERO: Self = 0;
}

impl Zero for u128 {
    const ZERO: Self = 0;
}

impl Zero for f32 {
    const ZERO: Self = 0.0;
}

impl Zero for f64 {
    const ZERO: Self = 0.0;
}

pub struct Triangle<T> {
    pub a: T,
    pub b: T,
    pub c: T,
}

/// Creates a new Triangle
///
/// Example
/// ```rust
/// use triangle::*;
///
/// let equilateral: [u64; 3] = [5, 5, 5];
/// let isosceles: [u64; 3] = [4, 7, 4];
/// let scalene: [u64; 3] = [2, 3, 4];
///
/// if let Some(t) = Triangle::build(equilateral) {
///     assert!(t.is_equilateral());
///     assert!(t.is_isosceles());
///     assert!(!t.is_scalene());
/// }
///
/// if let Some(t) = Triangle::build(isosceles) {
///     assert!(!t.is_equilateral());
///     assert!(t.is_isosceles());
///     assert!(!t.is_scalene());
/// }
///
/// if let Some(t) = Triangle::build(scalene) {
///     assert!(!t.is_equilateral());
///     assert!(!t.is_isosceles());
///     assert!(t.is_scalene());
/// }
/// ```
impl<T> Triangle<T>
where
    T: Copy + std::ops::Add<Output = T> + PartialOrd + PartialEq + Zero,
{
    pub fn build(sides: [T; 3]) -> Option<Triangle<T>> {
        match (sides[0], sides[1], sides[2]) {
            (a, b, c) if a <= T::ZERO || b <= T::ZERO || c <= T::ZERO => None,
            (a, b, c) if (a + b > c) && (a + c > b) && (b + c > a) => Some(Triangle { a, b, c }),
            _ => None,
        }
    }

    /// Tests triangle is equilateral
    pub fn is_equilateral(&self) -> bool {
        self.a == self.b && self.a == self.c
    }

    /// Tests triangle is scalene
    pub fn is_isosceles(&self) -> bool {
        self.a == self.b || self.b == self.c || self.a == self.c
    }

    /// Tests triangle is isosceles
    pub fn is_scalene(&self) -> bool {
        self.a != self.b && self.a != self.c && self.b != self.c
    }
}
