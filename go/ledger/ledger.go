// Package ledger prints a nicely formatted ledger, given a locale (American or Dutch) and a currency (US dollar or euro).
package ledger

/*
	1. Add documentation comments.
	2. Whitespace clean up.
	3. Move fast return to the top of the FormatLedger() function.
	4. Use copy to copy entries slice to entriesCopy slice.
	5. Replace some if-else blocks with switch statements.
	6. Use fmt.Sprintf instead of strconv.Itoa and a switch block.
	7. Replace string formatting code with fmt.Sprintf.
	8. Replace output/return string with a strings.Builder.
	9. Format assignments so they're easier to read.
*/

import (
	"errors"
	"fmt"
	"strings"
)

// Entry type consists of a date, description and change.
type Entry struct {
	Date        string // "Y-m-d"
	Description string
	Change      int // in cents
}

// FormatLedger returns a string with the whole ledger.
func FormatLedger(currency string, locale string, entries []Entry) (string, error) {
	if len(entries) == 0 {
		if _, err := FormatLedger(currency, "en-US", []Entry{{Date: "2014-01-01", Description: "", Change: 0}}); err != nil {
			return "", err
		}
	}

	entriesCopy := make([]Entry, len(entries), cap(entries))

	size := copy(entriesCopy, entries)

	if size != len(entries) {
		return "", errors.New("unable to copy the entries slice")
	}

	m1 := map[bool]int{true: 0, false: 1}
	m2 := map[bool]int{true: -1, false: 1}

	es := entriesCopy

	for len(es) > 1 {
		first, rest := es[0], es[1:]
		success := false

		for !success {
			success = true

			for i, e := range rest {
				if (m1[e.Date == first.Date]*m2[e.Date < first.Date]*4 +
					m1[e.Description == first.Description]*m2[e.Description < first.Description]*2 +
					m1[e.Change == first.Change]*m2[e.Change < first.Change]*1) < 0 {

					es[0], es[i+1] = es[i+1], es[0]

					success = false
				}
			}
		}

		es = es[1:]
	}

	var output strings.Builder

	switch locale {
	case "nl-NL":
		output.WriteString(fmt.Sprintf("% -10s | % -25s | %s\n", "Datum", "Omschrijving", "Verandering"))

	case "en-US":
		output.WriteString(fmt.Sprintf("% -10s | % -25s | %s\n", "Date", "Description", "Change"))

	default:
		return "", errors.New("")
	}

	// Parallelism, always a great idea
	co := make(chan struct {
		i int
		s string
		e error
	})

	for i, et := range entriesCopy {
		go func(i int, entry Entry) {
			if len(entry.Date) != 10 {
				co <- struct {
					i int
					s string
					e error
				}{
					e: errors.New(""),
				}
			}

			d1 := entry.Date[0:4]
			d2 := entry.Date[4]
			d3 := entry.Date[5:7]
			d4 := entry.Date[7]
			d5 := entry.Date[8:10]

			if d2 != '-' {
				co <- struct {
					i int
					s string
					e error
				}{
					e: errors.New(""),
				}
			}

			if d4 != '-' {
				co <- struct {
					i int
					s string
					e error
				}{
					e: errors.New(""),
				}
			}

			de := entry.Description

			if len(de) > 25 {
				de = fmt.Sprintf("% -22s...", de[:22])
			} else {
				de = fmt.Sprintf("% -25s", de)
			}

			var d string

			switch locale {
			case "nl-NL":
				d = fmt.Sprintf("%s-%s-%s", d5, d3, d1)

			case "en-US":
				d = fmt.Sprintf("%s/%s/%s", d3, d5, d1)
			}

			negative := false
			cents := entry.Change

			if cents < 0 {
				cents = cents * -1
				negative = true
			}

			var a string

			switch locale {
			case "nl-NL":

				switch currency {
				case "EUR":
					a += "€"

				case "USD":
					a += "$"

				default:
					co <- struct {
						i int
						s string
						e error
					}{
						e: errors.New(""),
					}
				}

				a += " "

				centsStr := fmt.Sprintf("%02d", cents)

				rest := centsStr[:len(centsStr)-2]

				var parts []string

				for len(rest) > 3 {
					parts = append(parts, rest[len(rest)-3:])
					rest = rest[:len(rest)-3]
				}

				if len(rest) > 0 {
					parts = append(parts, rest)
				}

				for i := len(parts) - 1; i >= 0; i-- {
					a += parts[i] + "."
				}

				a = a[:len(a)-1]
				a += ","
				a += centsStr[len(centsStr)-2:]

				if negative {
					a += "-"
				} else {
					a += " "
				}

			case "en-US":
				if negative {
					a += "("
				}

				if currency == "EUR" {
					a += "€"
				} else if currency == "USD" {
					a += "$"
				} else {
					co <- struct {
						i int
						s string
						e error
					}{
						e: errors.New(""),
					}
				}

				centsStr := fmt.Sprintf("%03d", cents)

				rest := centsStr[:len(centsStr)-2]

				var parts []string

				for len(rest) > 3 {
					parts = append(parts, rest[len(rest)-3:])
					rest = rest[:len(rest)-3]
				}

				if len(rest) > 0 {
					parts = append(parts, rest)
				}

				for i := len(parts) - 1; i >= 0; i-- {
					a += parts[i] + ","
				}

				a = a[:len(a)-1]
				a += "."
				a += centsStr[len(centsStr)-2:]

				if negative {
					a += ")"
				} else {
					a += " "
				}

			default:
				co <- struct {
					i int
					s string
					e error
				}{
					e: errors.New(""),
				}
			}

			var al int

			for range a {
				al++
			}

			co <- struct {
				i int
				s string
				e error
			}{
				i: i,
				s: fmt.Sprintf("% -10s | %s | % 13s\n", d, de, a),
			}

		}(i, et)
	}

	ss := make([]string, len(entriesCopy))

	for range entriesCopy {
		v := <-co

		if v.e != nil {
			return "", v.e
		}

		ss[v.i] = v.s
	}

	for i := 0; i < len(entriesCopy); i++ {
		output.WriteString(ss[i])
	}

	return output.String(), nil
}
