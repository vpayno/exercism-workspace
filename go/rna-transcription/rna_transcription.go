// Package strand is used to convert DNA sequences into RNA sequences.
package strand

import (
	"fmt"
	"regexp"
)

// DNA is a list of nucleotides.
type DNA string

// IsValid returns true if the DNA strand is valid.
func (d DNA) IsValid() (bool, error) {
	// Valid nucleotides.
	const nucleotides = "ACGT"

	if match, _ := regexp.MatchString(`^[`+nucleotides+`]+$`, string(d)); !match {
		return false, fmt.Errorf("DNA sequence, %q, contains invalid nucleotides", string(d))
	}

	return true, nil
}

// String returns a pretty formated representation of a DNA type.
func (d DNA) String() string {
	// we need string(d) here to prevent recursion
	return fmt.Sprintf("%s", string(d))
}

// ConvertToRNA returns a pretty formated representation of a DNA type.
func (d DNA) ConvertToRNA() RNA {
	if t, e := d.IsValid(); !t {
		panic(e)
	}

	dna2rna := map[rune]rune{
		'G': 'C',
		'C': 'G',
		'T': 'A',
		'A': 'U',
	}

	var rna RNA

	for _, r := range d {
		value, found := dna2rna[r]

		if found {
			rna += RNA(value)
		}
	}

	return rna
}

// RNA is a list of nucleotides.
type RNA string

// String returns a pretty formated representation of a DNA type.
func (d RNA) String() string {
	// we need string(d) here to prevent recursion
	return fmt.Sprintf("%s", string(d))
}

// ToRNA returns an RNA sequence from a DNA sequence.
func ToRNA(s string) string {
	if len(s) == 0 {
		return ""
	}

	var dna DNA = DNA(s)
	var rna RNA

	rna = dna.ConvertToRNA()

	return rna.String()
}
