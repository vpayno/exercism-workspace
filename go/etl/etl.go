// Package etl is used to convert scrablle scores from a legacy system to a new one.
package etl

import "strings"

// LegacyScore is the old data type.
type LegacyScore map[int][]string

// ModernScore is the new data type.
type ModernScore map[string]int

// Transform returns transformed data.
func Transform(legacy LegacyScore) ModernScore {
	var modern ModernScore = ModernScore{}

	for legacyScore, legacyLetters := range legacy {
		for _, r := range legacyLetters {
			//s := strings.ToLower(string(r))
			s := strings.ToLower(r)
			modern[s] = legacyScore
		}
	}

	return modern
}
