// Package diffsquares finds the difference between the square of the sum and the sum of the squares of the first N natural numbers.
package diffsquares

import "math"

// SquareOfSum returns the sum, `int`, of the square of the sum of the first n (`int`) numbers (starting with 1 to 10, inclusive).
// Using https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF
func SquareOfSum(n int) int {
	var sum int = (n * (n + 1)) / 2

	return int(math.Pow(float64(sum), 2.0))
}

// SumOfSquares returns the sum, `int`, of the sum of the first n (`int`) squares (starting with 1 to 10, inclusive).
// Using https://brilliant.org/wiki/sum-of-n-n2-or-n3/
func SumOfSquares(n int) int {
	var sum int = n * (n + 1) * (2*n + 1) / 6

	return sum
}

// Difference returns the difference between the Square of Sums and Sum of Squares.
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
