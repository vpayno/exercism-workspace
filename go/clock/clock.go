// Package clock that handles times without dates.
package clock

import "fmt"

// Clock struct that uses hours and minutes to represent time.
type Clock struct {
	h int
	m int
}

// normalize returns hours and minutes after the hours have been normalized (it's late, that's the best name I could think of).
func normalize(h, m int) (int, int) {
	for m < 0 {
		m += 60
		h--
	}

	for h < 0 {
		h += 24
	}

	var minutes int = h*60 + m

	if minutes > 60 {
		h = (minutes / 60) % 24
		m = minutes % 60
	}

	return h, m
}

// New returns a new clock with the normalized given hours and minutes.
func New(h, m int) Clock {
	h, m = normalize(h, m)

	return Clock{
		h: h,
		m: m,
	}
}

// Add returns a clock with the added minutes.
func (c Clock) Add(m int) Clock {
	c.h, c.m = normalize(c.h, c.m+m)

	return c
}

// Subtract returns a clock with the subtracted minutes.
func (c Clock) Subtract(m int) Clock {
	c.h, c.m = normalize(c.h, c.m-m)

	return c
}

// String retruns a string representation of the clock struct.
func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.h, c.m)
}
