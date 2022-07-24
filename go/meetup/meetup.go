// Package meetup is used to calculate the days a Meetup meets.
package meetup

import (
	"time"
)

/*
	Mo Tu We Th Fr Sa Su
	 1  2  3  4  5  6  7 - First
	 8  9 10 11 12 13 14 - Second
	15 16 17 18 19 20 21 - Third
	22 23 24 25 26 27 28 - Fourth
	29 30 31             - Fifth

	Teenth: (no overlapping days): 13-19
	- Saturday : 13
	- Sunday   : 14
	- Monday   : 15
	- Tuesday  : 16
	- Wednesday: 17
	- Thursday : 18
	- Friday   : 19
*/

// WeekSchedule enum for making requests for the day we're looking for.
type WeekSchedule int

// WeekSchedule enum values.
const (
	First  WeekSchedule = 1  // number of matches
	Second              = 2  // number of matches
	Third               = 3  // number of matches
	Fourth              = 4  // number of matches
	Teenth              = 13 // start search on this day
	Last                = 6  // number of matches
)

// Get the last day of the month (28, 29, 30, or 31)
// Needs to know for which month and year.
func getLastDayOfMonth(t time.Time) int {
	// Move the date to the first of the month which is always 1.
	var date time.Time = time.Date(t.Year(), t.Month(), 1, 12, 0, 0, 0, time.UTC)

	return date.AddDate(0, 1, -1).Day()
}

// Day returns the date the Meetup meets.
func Day(wSched WeekSchedule, wDay time.Weekday, month time.Month, year int) int {
	var date time.Time = time.Date(year, month, int(wSched), 12, 0, 0, 0, time.UTC)

	var start int = 1 // starting calendar day for the search
	var max int       // max number of matches
	var end int = getLastDayOfMonth(date)

	switch wSched {
	case First, Second, Third, Fourth:
		max = int(wSched)
	case Teenth:
		start = int(Teenth)
		max = 1
	case Last:
		end = getLastDayOfMonth(date)
		start = end - Last
		max = 1
	}

	var count int // number of matches
	var day int   // return value

	for d := start; d <= end; d++ {
		day = d

		// Use time.Date to get the month day number and name.
		t := time.Date(year, month, d, 12, 0, 0, 0, time.UTC)

		// Does the weekday name match?
		if wDay == t.Weekday() {
			count++
		}

		// End if we found the requested number of weekdays (max matches).
		if count >= max {
			break
		}
	}

	return day
}
