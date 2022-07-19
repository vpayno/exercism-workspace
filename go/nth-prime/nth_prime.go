// Package prime determines the nth prime.
package prime

import (
	"errors"
	"math"
	"sort"
)

// Nth returns the nth prime number. An error must be returned if the nth prime number can't be calculated ('n' is equal or less than zero)
func Nth(input int) (int, error) {
	if input < 1 {
		return 0, errors.New("the nth prime has to be equal to or greater than 1")
	}

	primes := []int{}
	var prime int

	// Using a large size to minimize the number of loops since each loop is
	// expensive.
	var searchSize int = input * 11

	for len(primes) <= input {
		primes = append(primes, findPrimeWithSieve(input, searchSize)...)

		prime = primes[input-1]

		searchSize *= 2
	}

	return prime, nil
}

// findPrimeWithSieve returns a list of primes up to the nth prime.
func findPrimeWithSieve(searchTarget int, limit int) []int {
	primes := []int{}

	// If limit is greater than 2 and is even, substract 1.
	if limit > 2 && limit%2 == 0 {
		limit--
	}

	// Index 2 to limit. These need to all be set to true.
	numbers := map[int]bool{}

	// - Only generate a list for '2' and odd numbers. All other even numbers
	//   aren't primes so they're automatically set to false so don't bother
	//   with them.
	if limit >= 2 {
		numbers[2] = true
	}
	for i := 3; i <= limit; i += 2 {
		numbers[i] = true
	}

	for number, isPrime := range numbers {
		if isPrime {
			for x, j := 1, number*number; j <= limit; x, j = x+1, number*number+x*number {
				numbers[j] = false
			}
		}
	}

	outer := 2
	sqrtLimit := int(math.Sqrt(float64(limit))) + 1

	var loop int
	var square int
	var inner int

	for outer <= sqrtLimit {

		if numbers[outer] {
			loop = 2
			square = outer * outer
			inner = square * (outer * (loop - 2))

			for inner <= limit {
				delete(numbers, inner)
				loop++
				inner = square * (outer * (loop - 2))
			}
		}

		outer++
	}

	for number, isPrime := range numbers {
		if isPrime {
			primes = append(primes, number)
		}
	}

	sort.Ints(primes)

	return primes
}
