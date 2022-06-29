// Package pangram determines if a sentence is a pangram.
package pangram

import (
	"regexp"
	"strings"
)

const alpha = "abcdefghijklmnopqrstuvwxyz"

// IsPangram returns true if the string contains all the ASCII letters (a to z).
func IsPangram(input string) bool {

	if len(input) == 0 {
		return false
	}

	// Get rid of all things not letters.
	reStr := `[[:^alpha:]]` // `([[:cntrl:]]|[[:digit:]]|[[:space:]]|[[:punct:]]|[[:xdigit:]])`

	re, e := regexp.Compile(reStr)
	if e != nil {
		// the raw re string is static but you can still make mistakes, better
		// to panic during tests than quietly "working" incorrectly.
		panic(e)
	}

	input = re.ReplaceAllString(input, "")

	// The string needs at least 26 letters to have the posibility of being a pangram.
	if len(input) < 26 {
		return false
	}

	// Make it lowercase to simplify checks.
	input = strings.ToLower(input)

	// Check to see if all 26 letters are in the string. Fail when we can't find one of them.
	for _, a := range alpha {
		if !strings.Contains(input, string(a)) {
			return false
		}
	}

	return true
}
