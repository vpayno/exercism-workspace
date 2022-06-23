// Package diffsquares finds the difference between the square of the sum and the sum of the squares of the first N natural numbers.
package diffsquares

import "math"

// SquareOfSum returns the sum, `int`, of the square of the sum of the first n (`int`) numbers (starting with 1 to 10, inclusive).
func SquareOfSum(n int) int {
	var sum int

	for i := 1; i <= n; i++ {
		sum += i
	}

	return int(math.Pow(float64(sum), 2.0))
}

// SumOfSquares returns the sum, `int`, of the sum of the first n (`int`) squares (starting with 1 to 10, inclusive).
func SumOfSquares(n int) int {
	var sum int

	for i := 1; i <= n; i++ {
		sum += int(math.Pow(float64(i), 2.0))
	}

	return sum
}

// Difference returns the difference between the Square of Sums and Sum of Squares.
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
