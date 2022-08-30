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
	10. Clean up localized code.
	11. Remove useless code.
	12. Clean up check for input date separator.
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

func localizedDate(locale, d1, d3, d5 string) (string, error) {
	var output string

	switch locale {
	case "nl-NL":
		output = fmt.Sprintf("%s-%s-%s", d5, d3, d1)

	case "en-US":
		output = fmt.Sprintf("%s/%s/%s", d3, d5, d1)

	default:
		return output, errors.New("failed to render localized date")
	}

	return output, nil
}

func localizedHeader(locale string) (string, error) {
	var output string

	fmtStr := "% -10s | % -25s | %s\n"

	switch locale {
	case "nl-NL":
		output = fmt.Sprintf(fmtStr, "Datum", "Omschrijving", "Verandering")

	case "en-US":
		output = fmt.Sprintf(fmtStr, "Date", "Description", "Change")

	default:
		return "", errors.New("failed to render localized header")
	}

	return output, nil
}

func localizedCurrency(locale, currency string, cents int) (string, error) {
	var output strings.Builder

	negative := false

	if cents < 0 {
		cents = cents * -1
		negative = true
	}

	switch locale {
	case "nl-NL":
		output.WriteString(" ")

	case "en-US":
		if negative {
			output.WriteString("(")
		} else {
			output.WriteString(" ")
		}
	}

	switch currency {
	case "EUR":
		output.WriteString("€")

	case "USD":
		output.WriteString("$")

	default:
		return "", errors.New("invalid currency")
	}

	if locale == "nl-NL" {
		output.WriteString(" ")
	}

	var centsStr string

	switch locale {
	case "nl-NL":
		centsStr = fmt.Sprintf("%02d", cents)

	case "en-US":
		centsStr = fmt.Sprintf("%03d", cents)
	}

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
		output.WriteString(parts[i])

		if i != 0 {
			switch locale {
			case "nl-NL":
				output.WriteString(".")

			case "en-US":
				output.WriteString(",")
			}
		} else {
			switch locale {
			case "nl-NL":
				output.WriteString(",")

			case "en-US":
				output.WriteString(".")
			}

		}
	}

	output.WriteString(centsStr[len(centsStr)-2:])

	switch locale {
	case "nl-NL":
		if negative {
			output.WriteString("-")
		} else {
			output.WriteString(" ")
		}

	case "en-US":
		if negative {
			output.WriteString(")")
		} else {
			output.WriteString(" ")
		}
	}

	return output.String(), nil
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

	header, err := localizedHeader(locale)

	if err != nil {
		return "", err
	}

	var output strings.Builder

	output.WriteString(header)

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

			if d2 != '-' || d4 != '-' {
				co <- struct {
					i int
					s string
					e error
				}{
					e: errors.New("invalid date separator"),
				}
			}

			de := entry.Description

			if len(de) > 25 {
				de = fmt.Sprintf("% -22s...", de[:22])
			} else {
				de = fmt.Sprintf("% -25s", de)
			}

			dateLine, err := localizedDate(locale, d1, d3, d5)

			if err != nil {
				co <- struct {
					i int
					s string
					e error
				}{
					e: err,
				}
			}

			currencyLine, err := localizedCurrency(locale, currency, entry.Change)

			if err != nil {
				co <- struct {
					i int
					s string
					e error
				}{
					e: err,
				}
			}

			co <- struct {
				i int
				s string
				e error
			}{
				i: i,
				s: fmt.Sprintf("% -10s | %s | % 13s\n", dateLine, de, currencyLine),
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
