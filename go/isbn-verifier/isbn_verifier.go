// Package isbn is used to validate book id numbers.
package isbn

import (
	"regexp"
	"strconv"
	"strings"
)

// IsValidISBN returns true if the book id number is valid.
func IsValidISBN(isbn string) bool {
	var sum int

	reStr := `^[0-9][0-9-]+([0-9]|X)$`

	match, error := regexp.MatchString(reStr, isbn)

	if error != nil {
		panic(error)
	}

	if !match {
		return false
	}

	isbn = strings.ReplaceAll(isbn, "-", "")

	if len(isbn) == 0 || len(isbn) < 10 {
		return false
	}

	for i, r := range isbn {
		if r == '-' {
			continue
		}

		var n int

		if r == 'X' {
			n = 10
		} else {
			n, error = strconv.Atoi(string(r))

			if error != nil {
				panic(error)
			}
		}

		d := 10 - i

		if d < 1 {
			return false
		}

		sum += n * d
	}

	if sum%11 == 0 {
		return true
	}

	return false
}
