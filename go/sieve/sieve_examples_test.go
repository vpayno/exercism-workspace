package sieve

import (
	"fmt"
)

func ExampleSieve() {
	numbers := []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
	for _, n := range numbers {
		fmt.Printf("%d: %v\n", n, Sieve(n))
	}
	// Output:
	// 0: []
	// 1: []
	// 2: [2]
	// 3: [2 3]
	// 4: [2 3]
	// 5: [2 3 5]
	// 6: [2 3 5]
	// 7: [2 3 5 7]
	// 8: [2 3 5 7]
	// 9: [2 3 5 7]
}
