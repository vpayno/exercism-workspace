// Package beer generates the lrics to the 99 Bootles of Beer on the Wall.
package beer

import (
	"errors"
	"fmt"
)

// Song returns the whole 99 Bottles of Beer on the Wall song.
func Song() string {
	lyrics, e := Verses(99, 0)

	if e != nil {
		panic(e)
	}

	return lyrics
}

// Verses returns select verselyricss 99 Bottles of Beer on the Wall song.
func Verses(start, stop int) (string, error) {
	var verses string
	var count int

	if start < stop {
		return "", fmt.Errorf("starting verse, %d, needs to be greater than or equal to the ending verse, %d", start, stop)
	}

	for i := start; i >= stop; i-- {
		verse, e := Verse(i)

		if e != nil {
			return "", e
		}

		verses += verse

		if count%2 == 0 {
			verses += "\n"
			count++
		}
		count = 0
	}

	return verses, nil
}

// Verse returns a single verse from 99 Bottles of Beer on the Wall song.
func Verse(beerCount int) (string, error) {
	var fs1 string = "%[1]d bottle%[2]s of beer on the wall, %[1]d bottle%[2]s of beer.\n"
	var fs2 string = "Take %[3]s down and pass it around, %[1]v bottle%[2]s of beer on the wall.\n"
	var countWord string = "one"
	var plural string

	if beerCount < 0 {
		return "", errors.New("you can't have a negative amount of beer bottles")
	}

	if beerCount > 99 {
		return "", errors.New("you can't have more than 99 beer bottles")
	}

	if beerCount == 0 {
		line1 := "No more bottles of beer on the wall, no more bottles of beer.\n"
		line2 := "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

		return line1 + line2, nil
	}

	if beerCount > 1 {
		plural = "s"
	}

	line1 := fmt.Sprintf(fs1, beerCount, plural)

	beerCount--

	if beerCount == 0 || beerCount > 1 {
		plural = "s"
	} else {
		plural = ""
	}

	beerWord := fmt.Sprintf("%d", beerCount)

	if beerCount == 0 {
		beerWord = "no more"
		countWord = "it"
		plural = "s"
	}

	line2 := fmt.Sprintf(fs2, beerWord, plural, countWord)

	return line1 + line2, nil
}
