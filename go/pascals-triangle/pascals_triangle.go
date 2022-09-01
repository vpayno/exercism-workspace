// Package pascal computes Pascal's Triangle.
package pascal

import (
	"errors"
)

// Triangle returns Pascal's Triangle for a given number.
func Triangle(limit int) [][]int {
	if limit <= 0 {
		return [][]int{}
	}

	triangle := [][]int{}

	for n := 0; n < limit; n++ {
		line := []int{1}

		for k := 1; k <= n; k++ {
			c, _ := NChooseK(n, k)
			line = append(line, c)
		}

		triangle = append(triangle, line)
	}

	return triangle
}

// Factorial returns the factorial of a number.
// https://en.wikipedia.org/wiki/Factorial
func Factorial(n int) (int, error) {
	if n < 0 {
		return 0, errors.New("Factorial(n): n must be >= 0")
	}

	f := 1

	for i := 2; i <= n; i++ {
		f *= i
	}

	return f, nil
}

// NChooseK returns the number of possible ways to choose 2 numbers from a set.
// https://en.wikipedia.org/wiki/Binomial_coefficient
func NChooseK(n, k int) (int, error) {
	if k < 0 {
		return 0, errors.New("NChooseK(n, k): k must be >= 0")
	}

	if n < k {
		return 0, errors.New("NChooseK(n, k): n must be >= k")
	}

	// Note: The fast return checks above prevent these from returning errors.
	t1, _ := Factorial(n)
	t2, _ := Factorial(k)
	t3, _ := Factorial(n - k)

	return t1 / (t2 * t3), nil
}
