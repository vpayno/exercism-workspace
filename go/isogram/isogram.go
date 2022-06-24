// Package isogram Determines if a word or phrase is an isogram.
package isogram

import (
	"regexp"
	"strings"
)

// IsIsogram returns true when a word is an isogram.
// An isogram (also known as a "non-pattern word") is a word or phrase without a repeating letter, however spaces and hyphens are allowed to appear multiple times.
func IsIsogram(word string) bool {
	r, e := regexp.Compile(`[^a-z]`)

	if e != nil {
		panic(e)
	}

	repl := func(match string) string {
		if match == "-" || match == " " {
			return ""
		}

		return strings.ToLower(match)
	}

	word = r.ReplaceAllStringFunc(word, repl)

	for i1, l1 := range word {
		for i2, l2 := range word {
			if i1 == i2 {
				continue
			}

			if l1 == l2 {
				return false
			}
		}
	}

	return true
}
