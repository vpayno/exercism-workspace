// Package raindrops converts a number into a string that contains raindrop sounds corresponding to certain potential factors.
package raindrops

import (
	"fmt"
	"strings"
)

// Convert returns a string containing raindrop sounds corresponding to factors of the number, `int`, given.
func Convert(number int) string {
	var sounds strings.Builder

	// Pre-allocate 15 Bytes.
	sounds.Grow(15)

	if number%3 == 0 {
		// Write to the buffer.
		sounds.WriteString("Pling")
	}

	if number%5 == 0 {
		// Write to the buffer.
		sounds.WriteString("Plang")
	}

	if number%7 == 0 {
		// Write to the buffer.
		sounds.WriteString("Plong")
	}

	// Check to see if the buffer is empty.
	if sounds.Len() == 0 {
		// Write to the buffer.
		sounds.WriteString(fmt.Sprintf("%d", number))
	}

	// Use the String() function to get the string from the buffer.
	return sounds.String()
}
