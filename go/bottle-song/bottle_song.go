// Package bottlesong generates the lrics to the Ten Green Bottles Bootles song.
// Adapted from the 99 Bottles of Beer exercise.
package bottlesong

import (
	"errors"
	"fmt"
	"strings"
)

// Number type let's us map numbers to strings for the song.
type Number int

// The numbers.
const (
	Zero Number = iota
	One
	Two
	Three
	Four
	Five
	Six
	Seven
	Eight
	Nine
	Ten
)

// The lower and upper bound numbers.
const (
	MinNumber = One
	MaxNumber = Ten
)

// NumberNames maps Number to string representations.
var NumberNames = map[Number]string{
	Zero:  "Zero",
	One:   "One",
	Two:   "Two",
	Three: "Three",
	Four:  "Four",
	Five:  "Five",
	Six:   "Six",
	Seven: "Seven",
	Eight: "Eight",
	Nine:  "Nine",
	Ten:   "Ten",
}

// String implements the Stringer interface for a Number.
func (n Number) String() string {
	return NumberNames[n]
}

// Int implements the Stringer interface for a Number.
func (n Number) Int() int {
	return int(n)
}

// Verse returns a single verse from 99 Bottles of Beer on the Wall song.
func Verse(bootleCount int) (string, error) {
	fs1 := "%[1]s green bottle%[2]s hanging on the wall,\n"
	fs2 := "And if one green bottle should accidentally fall,\n"
	fs3 := "There'll be %[1]s green bottle%[2]s hanging on the wall.\n"

	var plural string

	if bootleCount < MinNumber.Int() {
		return "", errors.New("you can't have zero or less bottles")
	}

	if bootleCount > MaxNumber.Int() {
		return "", errors.New("you can't have more than 10 bottles")
	}

	if bootleCount > MinNumber.Int() {
		plural = "s"
	}

	line1 := fmt.Sprintf(fs1, Number(bootleCount).String(), plural)
	line2 := fmt.Sprintf(fs1, Number(bootleCount).String(), plural)

	line3 := fs2

	bootleCount--

	if bootleCount == Zero.Int() || bootleCount > MinNumber.Int() {
		plural = "s"
	} else {
		plural = ""
	}

	bootleWord := strings.ToLower(Number(bootleCount).String())

	// yeah, I could have just used 0 here.
	if bootleCount == Zero.Int() {
		bootleWord = "no"
		plural = "s"
	}

	line4 := fmt.Sprintf(fs3, bootleWord, plural)

	return line1 + line2 + line3 + line4, nil
}

// Verses returns select verselyricss 10 Green Bottles Hanging on the Wall song.
func Verses(start, takeDown int) (string, error) {
	var verses string

	if start < takeDown {
		return "", fmt.Errorf("not enough bottles %[1]d to take down %[2]d", start, takeDown)
	}

	for line, count := start, takeDown; count > 0; line, count = line-1, count-1 {
		// This can't return an error because because of the other fast fails are making sure line is valid here.
		verse, _ := Verse(line)

		verses += verse

		if count > 1 {
			verses += "\n"
		}
	}

	return verses, nil
}

// Recite returns the verses of the song.
func Recite(startBottles, takeDown int) []string {
	if startBottles < MinNumber.Int() || startBottles > MaxNumber.Int() {
		return []string{}
	}

	if takeDown < MinNumber.Int() || takeDown > MaxNumber.Int() {
		return []string{}
	}

	data, _ := Verses(startBottles, takeDown)
	lines := strings.Split(data, "\n")

	return lines[:len(lines)-1]
}
