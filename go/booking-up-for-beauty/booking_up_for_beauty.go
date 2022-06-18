package booking

import (
	"fmt"
	"regexp"
	"time"
)

// Schedule returns a time.Time from a string containing a date
func Schedule(date string) time.Time {
	const layout = "1/02/2006 15:04:05"
	t, e := time.Parse(layout, date)

	if e != nil {
		panic(e)
	}

	return t
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	const layout = "January 2, 2006 15:04:05"
	t, e := time.Parse(layout, date)

	if e != nil {
		panic(e)
	}

	return t.Before(time.Now())
}

// IsAfternoonAppointment returns whether a time is in the afternoon
func IsAfternoonAppointment(date string) bool {
	var result bool

	const layout = "Monday, January 2, 2006 15:04:05"
	t, e := time.Parse(layout, date)

	if e != nil {
		panic(e)
	}

	hour := t.Hour()

	if hour >= 12 && hour < 18 {
		result = true
	} else {
		result = false
	}

	return result
}

// Description returns a formatted string of the appointment time
func Description(date string) string {
	const inputLayout = "1/2/2006 15:04:05"
	const outputLayout = "Monday, January 2, 2006, at 15:04:05"

	t, e := time.Parse(inputLayout, date)

	if e != nil {
		panic(e)
	}

	d := t.Format(outputLayout)

	re := regexp.MustCompile(`(.*[0-9][0-9]:[0-9][0-9]):[0-9][0-9]$`)

	appDate := re.ReplaceAllString(d, `$1`)

	return fmt.Sprintf("You have an appointment on %s.", appDate)
}

// AnniversaryDate returns a Time with this year's anniversary
func AnniversaryDate() time.Time {
	now := time.Now()
	anniversary := time.Date(now.Year(), time.September, 15, 0, 0, 0, 0, time.UTC)

	return anniversary
}
