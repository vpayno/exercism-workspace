// Package twelve resites the "Twelve Days of Christmas" lyrics.
package twelve

import (
	"fmt"
	"strings"
)

// Verse returns the specific verse/line from the song.
func Verse(verseNum int) string {
	verseNum--
	if verseNum < 0 || verseNum > 11 {
		return ""
	}

	linePrefix := "On the %s day of Christmas my true love gave to me: %s"

	days := []string{
		"first",
		"second",
		"third",
		"fourth",
		"fifth",
		"sixth",
		"seventh",
		"eighth",
		"ninth",
		"tenth",
		"eleventh",
		"twelfth",
	}

	items := []string{
		"a Partridge in a Pear Tree.",
		"two Turtle Doves, ",
		"three French Hens, ",
		"four Calling Birds, ",
		"five Gold Rings, ",
		"six Geese-a-Laying, ",
		"seven Swans-a-Swimming, ",
		"eight Maids-a-Milking, ",
		"nine Ladies Dancing, ",
		"ten Lords-a-Leaping, ",
		"eleven Pipers Piping, ",
		"twelve Drummers Drumming, ",
	}

	var verse string
	i := verseNum
	j := 0

	for j <= i {
		if j == 1 {
			verse = "and " + verse
		}

		verse = items[j] + verse
		j++
	}

	verse = fmt.Sprintf(linePrefix, days[i], verse)

	return verse
}

// Song returns the whole song.
func Song() string {
	var song strings.Builder

	for i := 1; i <= 12; i++ {
		song.WriteString(Verse(i))
		if i > 0 && i < 12 {
			song.WriteString("\n")
		}
	}

	return song.String()
}
