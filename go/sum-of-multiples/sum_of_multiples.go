// Package summultiples solves the Sum of Multiples Exercism.
package summultiples

// SumMultiples returns the sum of the multiples of the numbers passed that are below limit.
func SumMultiples(limit int, divisors ...int) int {
	if limit <= 0 || len(divisors) == 0 {
		return 0
	}

	divisors = DedupSlice(divisors)

	divisors = RemoveZeros(divisors)

	intSet := make(map[int]struct{})
	exists := struct{}{}

	for _, j := range divisors {
		for i := 1; i < limit; i++ {
			if i%j == 0 {
				intSet[i] = exists
			}
		}
	}

	var sum int

	// Note: only using the keys
	for multiple := range intSet {
		sum += multiple
	}

	return sum
}

// DedupSlice returns a deduped slice.
func DedupSlice(slice []int) []int {
	if len(slice) == 0 {
		return []int{}
	}

	newSlice := []int{}

	// Using a zero size struct is better than using a bool value.
	intSet := make(map[int]struct{})
	exists := struct{}{}

	for _, v := range slice {
		intSet[v] = exists
	}

	for v := range intSet {
		newSlice = append(newSlice, v)
	}

	return newSlice
}

// RemoveZeros returns a slice without 0s.
func RemoveZeros(slice []int) []int {
	if len(slice) == 0 {
		return []int{}
	}

	newSlice := []int{}

	for _, v := range slice {
		if v > 0 {
			newSlice = append(newSlice, v)
		}
	}

	return newSlice
}
