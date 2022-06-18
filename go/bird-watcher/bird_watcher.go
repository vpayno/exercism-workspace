package birdwatcher

// sum return the sum of the elements in an array or slice.
func sum(numbers ...int) int {
	var total int

	for _, number := range numbers {
		total += number
	}

	return total
}

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	return sum(birdsPerDay...)
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int {
	var daysInWeek int = 7
	var offsetStart, offsetEnd int

	offsetStart = (week - 1) * daysInWeek
	offsetEnd = daysInWeek * week

	return sum(birdsPerDay[offsetStart:offsetEnd]...)
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	for i := 0; i < len(birdsPerDay); i += 2 {
		birdsPerDay[i]++
	}

	return birdsPerDay
}
