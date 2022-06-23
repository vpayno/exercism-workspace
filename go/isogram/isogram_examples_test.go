package isogram

import (
	"fmt"
)

func ExampleIsIsogram() {
	words := []string{
		"Alphabet",
		"isograms",
		"isogram",
		"downstream",
		"six-year-old",
		"one-six",
	}

	for _, word := range words {
		fmt.Printf("%q: %v\n", word, IsIsogram(word))
	}
	// Output:
	// "Alphabet": false
	// "isograms": false
	// "isogram": true
	// "downstream": true
	// "six-year-old": true
	// "one-six": true
}
