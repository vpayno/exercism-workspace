package scrabble

import (
	"fmt"
)

func ExampleScore() {
	words := []string{
		"cabbage",
		"OxyphenButazone",
		"abcdefghijklmnopqrstuvwxyz",
		"1234",
		"abc123",
		"a b c",
	}

	for _, word := range words {
		fmt.Println(Score(word))
	}
	// Output:
	// 14
	// 41
	// 87
	// 0
	// 0
	// 0
}
