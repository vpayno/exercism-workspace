// Package proverb generates proverbial rhymes.
package proverb

import "fmt"

// Proverb returns a proverbial rhyme given a slice of words.
func Proverb(words []string) []string {
	if len(words) == 0 {
		return []string{}
	}

	rhyme := []string{}

	for i, j := 0, 1; j < len(words); i, j = i+1, j+1 {
		thisWord := words[i]
		nextWord := words[j]

		line := fmt.Sprintf("For want of a %s the %s was lost.", thisWord, nextWord)
		rhyme = append(rhyme, line)
	}

	firstWord := words[0]
	line := fmt.Sprintf("And all for the want of a %s.", firstWord)
	rhyme = append(rhyme, line)

	return rhyme
}
