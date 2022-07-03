// Package allyourbase is used to convert from any base to any other base.
package allyourbase

import (
	"errors"
	"fmt"
	"math"
	"strconv"
)

// ConvertToBase returns an integer slice of converted numbers.
func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
	var baseTenDigits int
	var outputDigits []int

	inputDigits, e := quickChecks(inputBase, outputBase, inputDigits)

	// If an error was picked up by quickChecks(), return it with a zero value int list.
	if e != nil {
		return inputDigits, e
	}

	// If zero, return zero.
	if len(inputDigits) == 1 && inputDigits[0] == 0 {
		return inputDigits, nil
	}

	// 1. Convert number from base x to base 10.
	if inputBase == 10 {
		var tmpStr string
		for _, n := range inputDigits {
			tmpStr += fmt.Sprintf("%d", n)
		}
		i, e := strconv.Atoi(tmpStr)

		if e != nil {
			panic(e)
		}

		baseTenDigits = i
	} else {
		baseTenDigits = ConvertToBase10(inputBase, inputDigits)
		// fmt.Printf("base: %d\tbaseTenDigits: %#v\n", outputBase, baseTenDigits)
	}

	// 2. Convert from base 10 to base y.
	if outputBase == 10 {
		outputDigits = ConvertIntToIntList(baseTenDigits)
		// fmt.Printf("base: %d\toutputDigits: %#v\n", outputBase, outputDigits)
		return outputDigits, nil
	}

	outputDigits = ConvertFromBase10(outputBase, baseTenDigits)
	// fmt.Printf("base: %d\toutputDigits: %#v\n", outputBase, outputDigits)

	return outputDigits, nil
}

// quickChecks returns a valid input list and nil or a zero value list with an
// error after performing input validation.
func quickChecks(inputBase int, outputBase int, inputDigits []int) ([]int, error) {
	if inputBase < 2 {
		return []int{}, errors.New("input base must be >= 2")
	}

	if outputBase < 2 {
		return []int{}, errors.New("output base must be >= 2")
	}

	if len(inputDigits) == 0 {
		return []int{0}, nil
	}

	var sum int
	for _, n := range inputDigits {
		sum += n
	}
	if sum == 0 {
		return []int{0}, nil
	}

	for _, n := range inputDigits {
		if n < 0 || n >= inputBase {
			return []int{}, errors.New("all digits must satisfy 0 <= d < input base")
		}
	}

	return inputDigits, nil
}

// mathPow returns the result of n ^ p.
// Using this to hide all the type castings.
func mathPow(n int, p int) int {
	return int(float64(math.Pow(float64(n), float64(p))))
}

// ConvertIntToIntList returns a list of intergers for the passed int.
func ConvertIntToIntList(num int) []int {

	s := fmt.Sprintf("%d", num)

	outputDigits := ConvertStrToIntList(s)

	return outputDigits
}

// ConvertStrToIntList returns a list of intergers for the passed string.
func ConvertStrToIntList(inputStr string) []int {
	outputDigits := []int{}

	for _, s := range inputStr {
		n, e := strconv.Atoi(string(s))

		if e != nil {
			panic(e)
		}

		outputDigits = append(outputDigits, n)
	}

	return outputDigits
}

// ConvertToBase10 returns a base 10 number.
func ConvertToBase10(inputBase int, inputDigits []int) int {
	var outputDigits int

	p := len(inputDigits) - 1

	var r int

	for _, n := range inputDigits {
		r = int(n * mathPow(inputBase, p))
		p--

		outputDigits += r
	}

	// fmt.Printf("base: %d\toutputDigits: %#v\n", 10, outputDigits)

	return outputDigits
}

// ConvertFromBase10 returns a base x number.
// It didn't make sense to pass the functions an int slice so I'm hiding that
// part of the algorithm in the function.
func ConvertFromBase10(outputBase int, inputNum int) []int {
	var outputDigits []int = []int{}
	var tmpDigits []int = []int{}
	var num int = inputNum

	var q, r int

	q = num

	for q > 0 {
		r = q % outputBase
		q /= outputBase

		tmpDigits = append(tmpDigits, r)
	}
	// fmt.Printf("base: %d\ttmpDigits: %#v\n", outputBase, tmpDigits)

	for i := len(tmpDigits) - 1; i >= 0; i-- {
		outputDigits = append(outputDigits, tmpDigits[i])
	}
	// fmt.Printf("base: %d\toutputDigits: %#v\n", outputBase, outputDigits)

	return outputDigits
}
