// Package anagram is a rearrangement of letters to form a new word.
package anagram

import (
	"sort"
	"strings"
)

// Detect returns a string slice anagram of the passed string.
func Detect(subject string, candidates []string) []string {
	var anagrams []string = []string{}
	var tmpSlice []string = []string{}
	var subjectLower string
	var candidateLower string

	subjectLower = strings.ToLower(subject)
	tmpSlice = strings.Split(subjectLower, "")
	sort.Strings(tmpSlice)
	sortedWord := strings.Join(tmpSlice, "")

	for _, candidate := range candidates {
		candidateLower = strings.ToLower(candidate)
		tmpSlice = strings.Split(candidateLower, "")
		sort.Strings(tmpSlice)
		sortedCandidate := strings.Join(tmpSlice, "")

		if sortedWord == sortedCandidate && subjectLower != candidateLower {
			anagrams = append(anagrams, candidate)
		}
	}

	return anagrams
}
