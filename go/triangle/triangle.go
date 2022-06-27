// Package triangle determines if a triangle is equilateral, isosceles, or scalene.
package triangle

// Kind is an int used to describe a triangle.
type Kind int

// Triangle types.
const (
	NaT = 0 // not a triangle
	Equ = 1 // equilateral
	Iso = 2 // isosceles
	Sca = 3 // scalene
)

// isTriangle returns true if the sides form a valid triangle.
func isTriangle(a, b, c float64) bool {
	if a <= 0 || b <= 0 || c <= 0 {
		return false
	}

	if a+b >= c && a+c >= b && b+c >= a {
		return true
	}

	return false
}

// isEquilateral returns true if the triangle has 3 equal sides.
func isEquilateral(a, b, c float64) bool {
	if !isTriangle(a, b, c) {
		return false
	}

	if a == b && a == c {
		return true
	}

	return false
}

// isIsosceles returns true if the triangle only has 2 equal sides.
func isIsosceles(a, b, c float64) bool {
	if !isTriangle(a, b, c) {
		return false
	}

	if a == b && a != c || b == c && b != a || a == c && a != b {
		return true
	}

	return false
}

// isScalene returns true if the triangle has no identical sides.
func isScalene(a, b, c float64) bool {
	if !isTriangle(a, b, c) {
		return false
	}

	if a != b && a != c && b != c {
		return true
	}

	return false
}

// KindFromSides returns the kind of triangle being tested.
func KindFromSides(a, b, c float64) Kind {
	switch {
	case isEquilateral(a, b, c):
		return Equ
	case isIsosceles(a, b, c):
		return Iso
	case isScalene(a, b, c):
		return Sca
	default:
		return NaT
	}
}
