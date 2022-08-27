// Package house generates the nursery rhyme "This is the House that Jack Built".
package house

import (
	"fmt"
	"strings"
)

// Verse returns a specific verse from the nursery rhyme.
func Verse(level int) string {
	level--

	if level < 0 || level > 11 {
		return ""
	}

	part1 := map[string]string{
		"0":                                "This is the",
		"horse and the hound and the horn": "This is the",
		"farmer sowing his corn":           "that belonged to the",
		"rooster that crowed in the morn":  "that kept the",
		"priest all shaven and shorn":      "that woke the",
		"man all tattered and torn":        "that married the",
		"maiden all forlorn":               "that kissed the",
		"cow with the crumpled horn":       "that milked the",
		"dog":                              "that tossed the",
		"cat":                              "that worried the",
		"rat":                              "that killed the",
		"malt":                             "that ate the",
		"house that Jack built.":           "that lay in the",
	}

	part2 := map[int]string{
		11: "horse and the hound and the horn",
		10: "farmer sowing his corn",
		9:  "rooster that crowed in the morn",
		8:  "priest all shaven and shorn",
		7:  "man all tattered and torn",
		6:  "maiden all forlorn",
		5:  "cow with the crumpled horn",
		4:  "dog",
		3:  "cat",
		2:  "rat",
		1:  "malt",
		0:  "house that Jack built.",
	}

	var verse strings.Builder

	for i, j := 0, level; i <= level; i, j = i+1, j-1 {
		var line strings.Builder

		if i == 0 {
			line.WriteString(fmt.Sprintf("%s %s", part1["0"], part2[j]))
		} else {
			line.WriteString(fmt.Sprintf("%s %s", part1[part2[j]], part2[j]))
		}

		verse.WriteString(line.String())

		if i != level {
			verse.WriteString("\n")
		}
	}

	return verse.String()
}

// Song returns the whole nursery rhyme.
func Song() string {
	var song strings.Builder

	for i := 1; i <= 12; i++ {
		song.WriteString(Verse(i))
		song.WriteString("\n")

		if i != 12 {
			song.WriteString("\n")
		}
	}

	// The test string doesn't end with a newline.
	return strings.TrimRight(song.String(), "\n")
}
