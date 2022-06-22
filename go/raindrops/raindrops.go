// Package raindrops converts a number into a string that contains raindrop sounds corresponding to certain potential factors.
package raindrops

import "fmt"

// Convert returns a string containing raindrop sounds corresponding to factors of the number, `int`, given.
func Convert(number int) string {
	var sounds string

	if number%3 == 0 {
		sounds += "Pling"
	}

	if number%5 == 0 {
		sounds += "Plang"
	}

	if number%7 == 0 {
		sounds += "Plong"
	}

	if sounds == "" {
		sounds = fmt.Sprintf("%d", number)
	}

	return sounds
}
