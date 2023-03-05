// Package sublist is used to compare two lists with each other.
package sublist

import (
	"fmt"
	"strings"
)

// ListToString returns a string representation of an int slice.
func ListToString(list []int) string {
	str := fmt.Sprint(list)
	str = strings.Trim(string(str), "[]")
	str += " "

	return str
}

// Sublist returns the relationship between two lists.
func Sublist(l1, l2 []int) Relation {

	if len(l1) == 0 && len(l2) == 0 {
		return RelationEqual
	}

	s1 := ListToString(l1)
	s2 := ListToString(l2)

	if len(l1) == len(l2) && s1 == s2 {
		return RelationEqual
	}

	if len(s1) > len(s2) && strings.Contains(s1, s2) {
		return RelationSuperlist
	}

	if len(s1) < len(s2) && strings.Contains(s2, s1) {
		return RelationSublist
	}

	return RelationUnequal
}
