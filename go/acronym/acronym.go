// Package acronym converts a phrase to its acronym.
// The 1st iteration is better than the second one.
package acronym

import (
	"regexp"
	"strings"
)

// Abbreviate returns an acronym from the supplied string.
func Abbreviate(s string) string {
	var a string

	// Since we can't use cases or language, we have to do some pre-processing.
	reStr := `(["'_;:.]|[[:digit:]])`

	re, e := regexp.Compile(reStr)
	if e != nil {
		// the raw re string is static but you can still make mistakes, better
		// to panic during tests than quietly "working" incorrectly.
		panic(e)
	}

	a = re.ReplaceAllString(s, "")

	// Get the title converted string.
	// Using deprecated function, the test harness doesn't run `go mod tidy` or
	// it also lacks Internet access.
	a = strings.ToLower(a)
	a = strings.Title(a)

	// Thought about looping through the string to find uppercase letters,
	// decided on just using regexp to remove everything else instead.
	// I've tried using the strings IsSomething functions befoer and they're a mess.
	reStr = `([[:lower:]]|[[:blank:]]|[[:punct:]])`

	re, e = regexp.Compile(reStr)
	if e != nil {
		// the raw re string is static but you can still make mistakes, better
		// to panic during tests than quietly "working" incorrectly.
		panic(e)
	}

	a = re.ReplaceAllString(a, "")

	return a
}
