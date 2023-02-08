// Package leap is used to report if a year is a leap year in the Gregorian calendar.
package leap

// IsLeapYear returns true if the year is a leap year.
//
// on every year that is evenly divisible by 4
// except every year that is evenly divisible by 100
// unless the year is also evenly divisible by 400
func IsLeapYear(year int) bool {
	if year%400 == 0 {
		return true
	}

	if year%100 == 0 {
		return false
	}

	if year%4 == 0 {

		return true
	}

	return false
}
