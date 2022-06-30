// Package wordcount is used to count word frequencies.
package wordcount

import (
	"regexp"
	"strings"
)

// Frequency is a map used to count word frequencies.
type Frequency map[string]int

// WordCount returns a frequency map for the words counts in the string.
func WordCount(phrase string) Frequency {

	// remove punctuation - except for '
	reStr := `["_;:.,!@$%^&]`
	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	phrase = re.ReplaceAllString(phrase, " ")

	// change [a-z]['][a-z] to _
	reStr = `([a-z])[']([a-z])`
	re, e = regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	phrase = re.ReplaceAllString(phrase, `${1}_${2}`)

	// remove extra '
	reStr = `[']`
	re, e = regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	phrase = re.ReplaceAllString(phrase, " ")

	// change _ to '
	reStr = `_`
	re, e = regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	phrase = re.ReplaceAllString(phrase, "'")

	// lowercase, trim space
	phrase = strings.ToLower(phrase)
	phrase = strings.TrimSpace(phrase)

	// convert all whitespace to single space
	reStr = `[[:space:]]+`
	re, e = regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	phrase = re.ReplaceAllString(phrase, " ")

	// split on whitespace
	words := strings.Split(phrase, " ")

	// walk slice and fill frequency map
	freqMap := Frequency{}
	for _, word := range words {
		freqMap[word]++
	}

	// return frequency map
	return freqMap
}
