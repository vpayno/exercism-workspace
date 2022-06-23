// Package twofer for https://exercism.org/tracks/go/exercises/two-fer
package twofer

import (
	"fmt"
)

// ShareWith returns a string with the sharing instructions.
func ShareWith(name string) string {
	if name == "" {
		return "One for you, one for me."
	}

	return fmt.Sprintf("One for %s, one for me.", name)
}
