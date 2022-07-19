// Package prime computes the prime factors of a given natural number.
package prime

// Factors returns an in64 list of prime factors for the given natural number.
func Factors(number int64) []int64 {
	factors := []int64{}
	var factor int64

	_getFactors := func() {
		for number%factor == 0 && number > 1 {
			number /= factor

			factors = append(factors, factor)
		}
	}

	factor = 2
	_getFactors()

	factor = 3

	for number > 1 {
		_getFactors()
		factor += 2
	}

	return factors
}
