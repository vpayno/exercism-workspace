package prime

import (
	"fmt"
)

func ExampleFactors() {
	fmt.Printf("%d: %v\n", 60, Factors(60))
	// Output:
	// 60: [2 2 3 5]
}
