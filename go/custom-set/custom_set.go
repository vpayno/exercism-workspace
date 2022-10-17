package stringset

import (
	"sort"
	"strings"
)

// Implement Set as a collection of unique string values.
//
// For Set.String, use '{' and '}', output elements as double-quoted strings
// safely escaped with Go syntax, and use a comma and a single space between
// elements. For example, a set with 2 elements, "a" and "b", should be formatted as {"a", "b"}.
// Format the empty set as {}.

// Define the Set type here.
type Set map[string]struct{}

// New returns a new empty Set.
func New() Set {
	return make(Set)
}

// NewFromSlice returns a new Set populated with the strings from the passed slice.
func NewFromSlice(list []string) Set {
	s := New()

	for _, v := range list {
		s.Add(v)
	}

	return s
}

// String returns the string version of the Set.
func (s Set) String() string {
	if len(s) == 0 {
		return "{}"
	}

	var sb strings.Builder

	sb.WriteString("{")

	var first = true

	list := []string{}

	for k, _ := range s {
		list = append(list, k)
	}

	sort.Strings(list)

	for _, v := range list {
		if !first {
			sb.WriteString(", ")
		} else {
			first = false
		}

		sb.WriteString(`"`)
		sb.WriteString(v)
		sb.WriteString(`"`)
	}

	sb.WriteString("}")

	return sb.String()
}

// IsEmpty returns true if the Set is empty, false if it isn't.
func (s Set) IsEmpty() bool {
	return len(s) == 0
}

// Has returns true if the string is found in the Set, false if it doesn't.
func (s Set) Has(elem string) bool {
	_, found := s[elem]

	return found
}

// Add inserts an element into the Set.
func (s Set) Add(elem string) {
	// No need to check if it already exists since map keys are unique.
	s[elem] = struct{}{}
}

// Subset returns true if s2 is a subset of s1.
func Subset(s1, s2 Set) bool {
	// TestSubset/empty_set_is_a_subset_of_another_empty_set
	if len(s1) == 0 && len(s2) == 0 {
		return true
	}

	// TestSubset/empty_set_is_a_subset_of_non-empty_set
	if len(s1) == 0 && len(s2) > 0 {
		return true
	}

	// TestSubset/non-empty_set_is_not_a_subset_of_empty_set
	if len(s1) > 0 && len(s2) == 0 {
		return false
	}

	for k, _ := range s1 {
		if !s2.Has(k) {
			return false
		}
	}

	return true
}

// Disjoint returns true when the intersection of two Sets is empty.
func Disjoint(s1, s2 Set) bool {
	return Intersection(s1, s2).IsEmpty()
}

// Equal returns true when two Sets are equal and false when they aren't.
func Equal(s1, s2 Set) bool {
	if len(s1) != len(s2) {
		return false
	}

	for k, _ := range s1 {
		if !s2.Has(k) {
			return false
		}
	}

	return true
}

// Intersection returns the common elements between two Sets.
func Intersection(s1, s2 Set) Set {
	i := New()

	if len(s1) > len(s2) {
		s1, s2 = s2, s1
	}

	for k, _ := range s1 {
		if s2.Has(k) {
			i.Add(k)
		}
	}

	return i
}

// Difference returns the difference between two Sets.
func Difference(s1, s2 Set) Set {
	d := New()

	for k, _ := range s1 {
		if !s2.Has(k) {
			d.Add(k)
		}
	}

	return d
}

// Union returns a Set composed of both Sets.
func Union(s1, s2 Set) Set {
	u := New()

	for k, _ := range s1 {
		u.Add(k)
	}

	for k, _ := range s2 {
		u.Add(k)
	}

	return u
}
