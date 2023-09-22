// Package romannumerals is used to convert numbers from decimals to roman numerals.
package romannumerals

import (
	"errors"
	"sort"
)

// ToRomanNumeral returns a roman numeral string and and error code.
func ToRomanNumeral(input int) (string, error) {
	if input <= 0 {
		return "", errors.New("Roman numerals can't be less than or equal to 0")
	}

	// Only process numbers <=3k.
	if input > 3_000 {
		return "", errors.New("Roman numerals were apparently rarely greater than 3k")
	}

	d2r := map[int]string{
		1:     "I",
		4:     "IV",
		5:     "V",
		9:     "IX",
		10:    "X",
		40:    "XL",
		50:    "L",
		90:    "XC",
		100:   "C",
		400:   "CD",
		500:   "D",
		900:   "CM",
		1_000: "M",
	}

	output := ""

	decimals := make([]int, 0, len(d2r))

	for d := range d2r {
		decimals = append(decimals, d)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(decimals)))

	for _, decimal := range decimals {
		roman := d2r[decimal]

		for input >= decimal {
			output += roman

			input -= decimal
		}
	}

	return output, nil
}
