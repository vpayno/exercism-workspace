package hamming

import (
	"errors"
	"regexp"
)

// isValidDNASequence returns true if the sequence only has the letters C, A, G, T.
func isValidDNASequence(sequence string) (bool, error) {
	match, err := regexp.MatchString(`^[CAGT]+$`, sequence)

	return match, err
}

// Distance returns an int for the Hamming Distance or 0 and an error if there aer issues.
func Distance(a, b string) (int, error) {
	var distance int

	// If the sequences aren't of equal length, fail.
	if len(a) != len(b) {
		return 0, errors.New("strings need to be of equal length")
	}

	// If both sequences are empty, return successfully (one of the tests treats empty sequences as valid).
	if a == "" && b == "" {
		return 0, nil
	}

	// Fail if the sequence is invalid.
	if t, _ := isValidDNASequence(a); !t {
		return 0, errors.New("sequence a isn't valid")
	}

	// Fail if the sequence is invalid.
	if t, _ := isValidDNASequence(b); !t {
		return 0, errors.New("sequence b isn't valid")
	}

	// Walk the sequences and compare each of the positions to see if they match.
	// If they don't, increment the distance counter.
	for i := range a {
		if a[i] != b[i] {
			distance++
		}
	}

	return distance, nil
}
