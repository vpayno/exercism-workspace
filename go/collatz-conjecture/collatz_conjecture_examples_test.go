package collatzconjecture

import (
	"fmt"
)

func ExampleCollatzConjecture() {
	var n int = 12

	s, e := CollatzConjecture(n)

	fmt.Printf("n = %d, steps to reach 1 = %d, error = %v\n", n, s, e)
	// Output:
	// n = 12, steps to reach 1 = 9, error = <nil>
}
