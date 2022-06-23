// Package scrabble Given a word, compute the Scrabble score for that word.
package scrabble

import (
	"regexp"
	"strings"
	"unicode"
)

// charScore returns an `int` score for a given letter (`string`).
func charScore(letter rune) int {
	letter = unicode.ToLower(letter)

	switch letter {
	case 'd', 'g':
		return 2
	case 'b', 'c', 'm', 'p':
		return 3
	case 'f', 'h', 'v', 'w', 'y':
		return 4
	case 'k':
		return 5
	case 'j', 'x':
		return 8
	case 'q', 'z':
		return 10
	default:
		// A, E, I, O, U, L, N, R, S, T
		return 1
	}
}

// Score returns an `int` scrablle score for a given word (`string`).
func Score(word string) int {
	var score int
	var letters string

	letters = strings.TrimSpace(word)

	// Make sure we have only have letters.
	if m, _ := regexp.MatchString(`^[a-zA-Z]+$`, word); !m {
		return 0
	}

	for _, letter := range letters {
		score += charScore(letter)
	}

	return score
}
