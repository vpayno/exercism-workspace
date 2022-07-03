// Package protein is used to translate RNA sequences into proteins.
package protein

import (
	"errors"
	"regexp"
)

// ErrStop is used to signal FromCodon to stop processing codons.
var ErrStop = errors.New("STOP")

// ErrInvalidBase is used to signal FronCodon that an invalid codon has been encountered.
var ErrInvalidBase = errors.New("Invalid Base")

// FromRNA returns a protein sequence from an RNA sequence.
func FromRNA(rna string) ([]string, error) {
	var codons []string = []string{}
	var proteins []string = []string{}

	reStr := `([[:upper:]]{3})`

	re, e := regexp.Compile(reStr)

	if e != nil {
		panic(e)
	}

	codons = re.FindAllString(rna, -1)

	for _, codon := range codons {
		protein, e := FromCodon(codon)

		if e == ErrStop {
			break
		} else if e != nil {
			return []string{}, e
		}

		proteins = append(proteins, protein)
	}

	return proteins, nil
}

// FromCodon returns a single protein from a codon.
func FromCodon(codon string) (string, error) {
	switch codon {
	case "AUG":
		return "Methionine", nil
	case "UUU", "UUC":
		return "Phenylalanine", nil
	case "UUA", "UUG":
		return "Leucine", nil
	case "UCU", "UCC", "UCA", "UCG":
		return "Serine", nil
	case "UAU", "UAC":
		return "Tyrosine", nil
	case "UGU", "UGC":
		return "Cysteine", nil
	case "UGG":
		return "Tryptophan", nil
	case "UAA", "UAG", "UGA":
		return "", ErrStop
	default:
		return "", ErrInvalidBase
	}
}
