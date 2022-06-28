package dna

import (
	"fmt"
)

func ExampleDNA_Valid() {
	var dna DNA = "ACGT"

	h, e := dna.Counts()
	fmt.Println(dna)
	fmt.Printf("h: %#v\ne: %v\n", h, e)
	// Output:
	// dna strand: "ACGT"
	// h: dna.Histogram{65:1, 67:1, 71:1, 84:1}
	// e: <nil>
}

func ExampleDNA_Invalid() {
	var dna DNA = "ACXGT"

	h, e := dna.Counts()
	fmt.Println(dna)
	fmt.Printf("h: %#v\ne: %v\n", h, e)
	// Output:
	// dna strand: "ACXGT"
	// h: dna.Histogram{65:0, 67:0, 71:0, 84:0}
	// e: DNA sequence, "ACXGT", contains invalid nucleotides
}
