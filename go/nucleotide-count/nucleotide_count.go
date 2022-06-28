// Package dna is a package used to inspect DNA sequences.
package dna

import (
	"errors"
	"fmt"
	"regexp"
)

// debug set to true to enable debug print statements.
var debug bool = false

// Histogram is a mapping from nucleotide to its count in given DNA.
// Choose a suitable data type.
type Histogram map[rune]int

// DNA is a list of nucleotides.
type DNA string

// Valid nucleotides.
const nucleotides = "ACGT"

// Counts generates a histogram of valid nucleotides in the given DNA.
// Returns an error if d contains an invalid nucleotide.
///
// Counts is a method on the DNA type. A method is a function with a special receiver argument.
// The receiver appears in its own argument list between the func keyword and the method name.
// Here, the Counts method has a receiver of type DNA named d.
func (d DNA) Counts() (Histogram, error) {
	var h Histogram = Histogram{
		'A': 0,
		'C': 0,
		'G': 0,
		'T': 0,
	}

	if len(d) == 0 {
		return h, nil
	}

	if match, _ := regexp.MatchString(`^[`+nucleotides+`]+$`, string(d)); !match {
		return h, errors.New("DNA sequence contains invalid nucleotides")
	}

	for _, nucleotide := range d {
		h[nucleotide]++
	}

	if debug {
		fmt.Printf("dna: %q\n", d)
		fmt.Printf("historgram: %#v\n", h)
	}

	return h, nil
}
