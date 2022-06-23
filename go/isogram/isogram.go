// Package isogram Determines if a word or phrase is an isogram.
package isogram

import "strings"

// IsIsogram returns true when a word is an isogram.
// An isogram (also known as a "non-pattern word") is a word or phrase without a repeating letter, however spaces and hyphens are allowed to appear multiple times.
func IsIsogram(word string) bool {
	word = strings.TrimSpace(word)
	word = strings.ToLower(word)

	for i1, l1 := range word {
		// Don't check hyphens or spaces.
		if l1 == '-' || l1 == ' ' {
			continue
		}

		for i2, l2 := range word {
			if i1 == i2 || l2 == '-' || l2 == ' ' {
				continue
			}

			if l1 == l2 {
				return false
			}
		}
	}

	return true
}
