// Package lsproduct is used to calculate the largest product from a series of
// numbers.
package lsproduct

import (
	"errors"
	"regexp"
	"strconv"
)

// LargestSeriesProduct returns the largest product for a contiguous substring
// of digits of length n.
func LargestSeriesProduct(digits string, span int) (int64, error) {
	if span < 0 {
		return 0, errors.New("span must not be negative")
	}

	if span > len(digits) {
		return 0, errors.New("span must be smaller than string length")
	}

	if len(digits) == 0 {
		return 1, nil
	}

	if span == 0 && len(digits) > 0 {
		return 1, nil
	}

	match, e := regexp.MatchString(`^[[:digit:]]+$`, digits)
	if e != nil {
		return 0, e
	}
	if !match {
		return 0, errors.New("digits input must only contain digits")
	}

	match, e = regexp.MatchString(`^0+$`, digits)
	if e != nil {
		return 0, e
	}
	if match {
		return 0, nil
	}

	match, e = regexp.MatchString(`^1+$`, digits)
	if e != nil {
		return 0, e
	}
	if match {
		return 1, nil
	}

	var result int64
	for len(digits) >= span {
		numbers := []int64{}

		for _, digit := range digits[:span] {
			number, e := strconv.Atoi(string(digit))
			if e != nil {
				return 0, e
			}

			numbers = append(numbers, int64(number))
		}

		digits = digits[1:]

		var product int64 = 1

		for _, n := range numbers {
			product *= n
		}

		if product > result {
			result = product
		}
	}

	return result, nil
}
