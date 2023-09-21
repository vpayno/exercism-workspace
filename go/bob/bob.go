// Package bob is a lackadaisical teenage AI.
package bob

import (
	"regexp"
	"strings"
)

// Hey returns a response from the simulated teenager.
func Hey(remark string) string {
	// The extra whitespace just gets in the way.
	remark = strings.TrimSpace(remark)

	var reStr string

	// Question without letters.
	reStr = `^([[:punct:]|[[:space:]])+[?]$`
	if m, e := regexp.MatchString(reStr, remark); m {
		if e != nil {
			panic(e)
		}

		return "Sure."
	}

	// Yelling a question.
	reStr = `^([[:upper:]]|[[:punct:]|[[:space:]])+[?]$`
	if m, e := regexp.MatchString(reStr, remark); m {
		if e != nil {
			panic(e)
		}

		return "Calm down, I know what I'm doing!"
	}

	// Any normal question.
	reStr = `^([[:alpha:]]|[[:digit:]]|[[:punct:]])([[:alpha:]]|[[:digit:]]|[[:punct:]]|[[:space:]])*[?]$`
	if m, e := regexp.MatchString(reStr, remark); m {
		if e != nil {
			panic(e)
		}

		return "Sure."
	}

	// Letterless statement.
	reStr = `^([[:digit:]]|[[:punct:]|[[:space:]])+$`
	if m, e := regexp.MatchString(reStr, remark); m {
		if e != nil {
			panic(e)
		}

		return "Whatever."
	}

	// Yelling statement.
	reStr = `^([[:upper:]]|[[:digit:]]|[[:punct:]|[[:space:]])+$`
	if m, e := regexp.MatchString(reStr, remark); m {
		if e != nil {
			panic(e)
		}

		return "Whoa, chill out!"
	}

	// Silence
	reStr = `^[[:space:]]*$`
	if m, e := regexp.MatchString(reStr, remark); m {
		if e != nil {
			panic(e)
		}

		return "Fine. Be that way!"
	}

	// Default response.
	return "Whatever."
}
