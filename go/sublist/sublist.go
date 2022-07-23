// Package sublist is used to compare two lists with each other.
package sublist

import (
	"fmt"
	"strings"
)

// Relation is a string that shows the relationship between two lists.
type Relation string

// "Enum" of list relations.
const (
	EqualR     Relation = "equal"
	UnequalR            = "unequal"
	SuperlistR          = "superlist"
	SublistR            = "sublist"
)

// ListToString returns a string representation of an int slice.
func ListToString(list []int) string {
	str := fmt.Sprint(list)
	str = strings.Trim(string(str), "[]")
	str = strings.ReplaceAll(str, " ", "")

	return str
}

// Sublist returns the relationship between two lists.
func Sublist(l1, l2 []int) Relation {

	if len(l1) == 0 && len(l2) == 0 {
		return EqualR
	}

	s1 := ListToString(l1)
	s2 := ListToString(l2)

	if len(l1) == len(l2) && s1 == s2 {
		return EqualR
	}

	if len(s1) > len(s2) && strings.Contains(s1, s2) {
		return SuperlistR
	}

	if len(s1) < len(s2) && strings.Contains(s2, s1) {
		return SublistR
	}

	return UnequalR
}
