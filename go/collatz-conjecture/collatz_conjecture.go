// Package collatzconjecture states that the orbit of every number under f eventually reaches 1.
package collatzconjecture

import "fmt"

// CollatzConjecture returns the number of steps needed to reach 1 using The Collatz Conjecture.
func CollatzConjecture(n int) (int, error) {

	// The number needs to be positive and greater than zero.
	if n < 1 {
		return 0, fmt.Errorf("n, %d, isn't a positive number", n)
	}

	// Fast return if n is already 1.
	if n == 1 {
		return 0, nil
	}

	var steps int

	for n > 1 {
		steps++

		if n%2 == 0 {
			// If n is even, divide n by 2 to get n / 2.
			n /= 2
		} else {
			// If n is odd, multiply n by 3 and add 1 to get 3n + 1.
			n = n*3 + 1
		}
	}

	return steps, nil
}
