// Package luhn is a simple checksum formula used to validate a variety of identification numbers, such as credit card numbers and Canadian Social Insurance Numbers.
package luhn

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

// debug set to true to enable debugging output.
var debug bool = false

// dPrint prints the passed output when the global var `debug` is true.
func dPrint(s string, a ...interface{}) {
	if debug {
		fmt.Println("DEBUG:", s, "=", a)
	}
}

// reverse returns a reversed string.
func reverse(s string) string {
	var b string

	for _, r := range s {
		b = string(r) + b
	}

	return b
}

// isValidInput returns true when the string only has digits or spaces in it and has a length greater than 1.
func isValidInput(s string) bool {
	if len(s) <= 1 {
		return false
	}

	m, e := regexp.MatchString(`^[0-9]+$`, s)

	if e != nil {
		panic(e)
	}

	return m
}

// Valid returns true when the passed number (`string`) is a valid luhn number.
func Valid(id string) bool {
	var sum int

	dPrint("id", id)

	// 0. remove spaces from the string
	id = strings.ReplaceAll(id, " ", "")

	// 1. is the string is valid?
	if !isValidInput(id) {
		return false
	}

	dPrint("id", id)

	di := reverse(id)

	dPrint("di", di)

	// 2. reverse the string
	// 3. double numbers with index 1, 3, 5, ...
	// 4. if the doubled number is > 9, subtract 9 from it
	// 5. sum the numbers.
	for i, r := range di {
		dPrint("r", string(r))
		s := string(r)
		n, e := strconv.Atoi(s)

		if e != nil {
			panic(e)
		}

		if i%2 != 0 {
			n *= 2

			if n > 9 {
				n -= 9
			}
		}

		dPrint("n", n)

		sum += n
	}

	// 6. if the sum is divisible by 10, it's valid
	return sum%10 == 0
}
