// Package armstrong checks that a number is an Armstrong number.
package armstrong

import (
	"fmt"
	"math"
	"strconv"
)

// IsNumber returns true if the passed number equals the sum of it's digits to
// the power of the number of digits.
func IsNumber(number int) bool {
	var digits string = fmt.Sprintf("%d", number)
	var exponent float64 = float64(len(digits))
	var sum int

	for _, r := range digits {
		n, e := strconv.Atoi(string(r))
		if e != nil {
			panic(e)
		}

		f := float64(n)
		sum += int(math.Pow(f, exponent))
	}

	if number == sum {
		return true
	}

	return false
}
