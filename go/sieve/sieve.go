// Package sieve of Eratosthenes is used to find all the primes from 2 up to a
// given number.
package sieve

import (
	"sort"
)

// Sieve returns a list of prime numbers using the Sieve of Eratosthenes.
// https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
// Litering the code with optimization todos so I can play with Go benchmarks.
/*
	algorithm Sieve of Eratosthenes is
		input: an integer n > 1.
		output: all prime numbers from 2 through n.

		let A be an array of Boolean values, indexed by integers 2 to n,
		initially all set to true.

		for i = 2, 3, 4, ..., not exceeding √n do
			if A[i] is true
				for j = i2, i2+i, i2+2i, i2+3i, ..., not exceeding n do
					set A[j] := false

		return all i such that A[i] is true.
*/
func Sieve(limit int) []int {
	primes := []int{}

	// TODO: If limit is even, substract 1.

	// Index 2 to limit. These need to all be set to true.
	// TODO:
	// - Only generate a list for '2' and odd numbers. All other even numbers
	//   aren't primes so they're automatically set to false so don't bother
	//   with them.
	numbers := map[int]bool{}

	for i := 2; i <= limit; i++ {
		numbers[i] = true
	}
	// fmt.Printf("numbers: %#v\n", numbers)

	for number, isPrime := range numbers {
		// fmt.Printf("number: %d\nisPrime: %v\n", number, isPrime)

		if isPrime {
			for x, j := 1, number*number; j <= limit; x, j = x+1, number*number+x*number {
				// fmt.Printf("\tx: %d\tj: %d\t", x, j)
				// fmt.Printf("i^2 + xi => %d^2 + %d*%d => %d\n", number, x, number, j)
				numbers[j] = false
			}
		}
	}

	for number, isPrime := range numbers {
		if isPrime {
			primes = append(primes, number)
		}
	}

	sort.Ints(primes)

	return primes
}

// TODO: Write and benchmark a Sieve64(int64) []int64 function.
