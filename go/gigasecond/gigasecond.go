// This is a "stub" file.  It's a little start on your solution.
// It's not a complete solution though; you have to write some code.

// Package gigasecond determines the time now plus 1 gigasecond.
package gigasecond

import "time"

// AddGigasecond returns the current time plus 1 gigasecond.
func AddGigasecond(t time.Time) time.Time {

	gigasecond, _ := time.ParseDuration("1000000000s")

	return t.Add(gigasecond)
}
