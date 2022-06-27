// Package leap is used to report if a year is a leap year in the Gregorian calendar.
package leap

// IsLeapYear retuns true if the year is a leap year.
func IsLeapYear(year int) bool {
	if year%4 == 0 {

		if year%400 == 0 {
			return true
		}

		if year%100 == 00 {
			return false
		}

		return true
	}

	return false
}
