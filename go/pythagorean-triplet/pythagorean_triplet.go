// Package pythagorean is used to find the triplets that sum to N.
package pythagorean

// Triplet represents the Pythagorean Triplet.
// for a^2 + b^2 = c^2 -> a + b + c = N
type Triplet [3]int

// Range returns a list of all Pythagorean triplets with side lengths in the provided range.
func Range(min, max int) []Triplet {
	triplets := []Triplet{}

	if min < 1 || max < 2 || max < min {
		return triplets
	}

	for a := min; a <= max; a++ {
		for b := a; b <= max; b++ {
			for c := b; c <= max; c++ {
				if CheckPythagoreanTriplets(a, b, c) {
					triplets = append(triplets, Triplet{a, b, c})
				}
			}
		}
	}

	return triplets
}

// Square returns the passed number to the power of 2.
func Square(n int) int {
	return n * n
}

// CheckPythagoreanTriplets returns true when the triplets pass the checks.
func CheckPythagoreanTriplets(a, b, c int) bool {
	// a < b < c
	if a > b && b > c {
		return false
	}

	// a² + b² = c²
	if Square(a)+Square(b) != Square(c) {
		return false
	}

	return true
}

// TripletSum returns the sum of the Pythagorean Triplets.
func TripletSum(t Triplet) int {
	var sum int

	for _, n := range t {
		sum += n
	}

	return sum
}

// Sum returns a list of all Pythagorean triplets with a certain perimeter.
// The instructions are really vague, I'm guessing min=1 and max=perimeter.
func Sum(perimeter int) []Triplet {
	if perimeter < 1 {
		return []Triplet{}
	}

	triplets := []Triplet{}

	for _, triplet := range Range(1, perimeter) {
		if TripletSum(triplet) == perimeter {
			triplets = append(triplets, triplet)
		}
	}

	return triplets
}
