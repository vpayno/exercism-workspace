// Package diffsquares finds the difference between the square of the sum and the sum of the squares of the first N natural numbers.
package diffsquares

import "math"

// Set to "gauss" to use an optimized agorithm.
var defaultMethod string = "gauss"

// SquareOfSum returns the sum, `int`, of the square of the sum of the first n (`int`) numbers (starting with 1 to 10, inclusive).
func SquareOfSum(n int) int {
	if defaultMethod == "gauss" {
		return squareOfSumGauss(n)
	}

	return squareOfSumBruteForce(n)
}

// squareOfSumGauss returns the sum using https://brilliant.org/wiki/sum-of-n-n2-or-n3/
func squareOfSumGauss(n int) int {
	var sum int = n * (n + 1) / 2

	return int(math.Pow(float64(sum), 2.0))
}

// squareOfSumBruteForce returns the sum using brute force.
func squareOfSumBruteForce(n int) int {
	var sum int

	for i := 1; i <= n; i++ {
		sum += i
	}

	return int(math.Pow(float64(sum), 2.0))
}

// SumOfSquares returns the sum, `int`, of the sum of the first n (`int`) squares (starting with 1 to 10, inclusive).
func SumOfSquares(n int) int {
	if defaultMethod == "gauss" {
		return sumOfSquaresGauss(n)
	}

	return sumOfSquaresBruteForce(n)
}

// squareOfSumGauss returns the sum using https://brilliant.org/wiki/sum-of-n-n2-or-n3/
func sumOfSquaresGauss(n int) int {
	var sum int = n * (n + 1) * (2*n + 1) / 6

	return sum
}

// sumOfSquaresBruteForce returns the sum using brute force.
func sumOfSquaresBruteForce(n int) int {
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
