// Package perfect is used to determinte the classification scheme of a number using Nicomachus' classification scheme for positive integers.
package perfect

import "errors"

// Classification type used in Nicomachus' classification scheme.
type Classification int

// The Classification enum.
const (
	Unknown Classification = iota
	ClassificationAbundant
	ClassificationDeficient
	ClassificationPerfect
)

// ClassificationNames maps the classifications to strings mappings.
var ClassificationNames = map[Classification]string{
	Unknown:                 "unknown",
	ClassificationAbundant:  "abundant",
	ClassificationDeficient: "deficient",
	ClassificationPerfect:   "perfect",
}

// String returns the lowercased classification name.
func (c Classification) String() string {
	switch c {
	case ClassificationAbundant:
		return ClassificationNames[ClassificationAbundant]
	case ClassificationDeficient:
		return ClassificationNames[ClassificationDeficient]
	case ClassificationPerfect:
		return ClassificationNames[ClassificationPerfect]
	default:
		return ClassificationNames[Unknown]
	}
}

// ErrOnlyPositive is returned when an input number is not positive.
var ErrOnlyPositive error = errors.New("only positive errors")

// Classify returns the classification of a number based on Nicomachus' classification scheme for positive integers.
func Classify(number int64) (Classification, error) {
	if number <= 0 {
		return Unknown, ErrOnlyPositive
	}

	// Factors: factors including 1 but not n.
	factors := Factors(number)

	// Aliquot sum: the sum of factors of a number.
	aliquotSum := Sum(factors)

	switch {
	case aliquotSum > number:
		return ClassificationAbundant, nil
	case aliquotSum < number:
		return ClassificationDeficient, nil
	case aliquotSum == number:
		return ClassificationPerfect, nil
	}

	return 0, nil
}

// Sum returns the sum of the list of numbers.
func Sum(numbers []int64) int64 {
	if len(numbers) == 0 {
		return 0
	}

	var sum int64

	for _, i := range numbers {
		sum += i
	}

	return sum
}

// Factors returns an int64 list of factors the given natural number.
// We include 1 but not the number itself.
func Factors(number int64) []int64 {
	if number == 0 {
		return []int64{}
	}

	factors := []int64{}
	var factor int64

	for factor = 1; factor < number; factor++ {
		if number%factor == 0 {
			factors = append(factors, factor)
		}
	}

	return factors
}
