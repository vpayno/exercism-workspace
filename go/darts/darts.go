// Package darts is used to calculate the score in a game of darts.
package darts

import (
	"math"
)

// Score returns a score for a single dart throw.
func Score(x, y float64) int {
	var radius float64

	// Figure out where the dart landed using it's (x, y) coordinate.
	// r^2 = (x – h)^2 + (y – k)^2
	radius = math.Sqrt(math.Pow(x-0, 2) + math.Pow(y-0, 2))

	switch {
	case radius > 5 && radius <= 10:
		return 1
	case radius > 1 && radius <= 5:
		return 5
	case radius <= 1:
		return 10
	default:
		return 0
	}
}
