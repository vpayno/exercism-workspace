// Package acronym converts a phrase to its acronym.
package acronym

import (
	"regexp"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

// Abbreviate returns an acronym from the supplied string.
func Abbreviate(s string) string {
	var a string

	// Pick a language (string.Title() is deprecated so we need to use the cases module).
	c := cases.Title(language.English)

	// Get the title converted string.
	a = c.String(s)

	// Thought about looping through the string to find uppercase letters,
	// decided on just using regexp to remove everything else instead.
	// I've tried using the strings IsSomething functions befoer and they're a mess.
	reStr := `([[:lower:]]|[[:blank:]]|[[:punct:]]|[[:digit:]])`

	re, e := regexp.Compile(reStr)
	if e != nil {
		// the raw re string is static but you can still make mistakes, better
		// to panic during tests than quietly "working" incorrectly.
		panic(e)
	}

	a = re.ReplaceAllString(a, "")

	return a
}
