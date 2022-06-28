package dna

import (
	"fmt"
)

func ExampleCounts() {
	var dna DNA = "ACGT"

	h, e := dna.Counts()
	fmt.Printf("h: %#v\ne: %v\n", h, e)
	// Output:
	// h: dna.Histogram{65:1, 67:1, 71:1, 84:1}
	// e: <nil>
}
