// Package romannumerals is used to convert numbers from decimals to roman numerals.
package romannumerals

import (
	"errors"
	"strings"
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

	/*
	   Steps
	   1. set remainder to number
	   2. divide remainder by 1000
	   3. if == 0 then look for special case for IV, IX, XL, XC, CD, CM
	      a. if true then record it and substract it from the remainder
	      b. if false continue with the next number
	   4. if != 0 then
	      a. output n, nn, nnn case
	      b. update the remainder
	      c. continue with the next number
	*/

	var d2r map[int]string = map[int]string{
		1:     "I",
		5:     "V",
		10:    "X",
		50:    "L",
		100:   "C",
		500:   "D",
		1_000: "M",
	}

	var subLadder map[int]int = map[int]int{
		10:    1,
		50:    10,
		100:   10,
		500:   100,
		1_000: 100,
	}

	var outLadder map[int]string = map[int]string{
		10:    "I",
		50:    "X",
		100:   "X",
		500:   "C",
		1_000: "C",
	}

	var remainder int = input
	var output string
	var register int

	var numbers []int = []int{1_000, 500, 100, 50, 10, 5, 1}

	for _, next := range numbers {

		if remainder <= 0 {
			break
		}

		register = remainder / next

		if register == 0 {
			subNum, found := subLadder[next]

			if !found {
				subNum = 1
			}

			if remainder >= next-subNum {

				// IV IX XL XC CD CM
				value, found := outLadder[next]

				if !found {
					value = "I"
				}

				output += value

				value, found = d2r[next]

				if !found {
					value = ""
				}

				output += value

				register = remainder - (next - subNum)

				remainder = register

			}

			continue

		} else {

			value, found := d2r[next]

			if !found {
				value = ""
			}

			// III xxx CCC
			output += strings.Repeat(value, register)

			register = remainder % next

			remainder = register

			continue
		}
	}

	return output, nil
}
