// Package series returns contiguous substrings from a string.
package series

import (
	"fmt"
	"regexp"
)

// All returns all the contiguous substrings of length n in that string in the order that they appear.
func All(size int, input string) []string {
	var offset int
	segments := []string{}

	reStr := `[[:digit:]]{` + fmt.Sprint(size) + `}`
	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}

	for {
		// It was easier to not use FindAllString().
		segment := re.FindString(input[offset:])
		if segment == "" {
			break
		}

		segments = append(segments, segment)

		offset++
		if offset > len(input)-(size-1) {
			break
		}
	}

	return segments
}

// UnsafeFirst return the first contiguous substrings of length n in that string.
func UnsafeFirst(size int, input string) string {
	if size > len(input) {
		return ""
	}

	segments := All(size, input)

	if len(segments) > 0 {
		return segments[0]
	}

	return ""
}
