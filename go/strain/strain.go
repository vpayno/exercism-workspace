// Package strain implements collection keep and discard functions.
package strain

// Ints integer collection.
type Ints []int

// Lists slice integer collection.
type Lists [][]int

// Strings string collection.
type Strings []string

// Keep returns a new collection containing those elements where the predicate is true.
func (i Ints) Keep(filter func(int) bool) Ints {
	if i == nil {
		return Ints(nil)
	}

	list := Ints{}

	for _, v := range i {
		if filter(v) {
			list = append(list, v)
		}
	}

	return list
}

// Discard returns a new collection containing those elements where the predicate is false.
func (i Ints) Discard(filter func(int) bool) Ints {
	if i == nil {
		return Ints(nil)
	}

	list := Ints{}

	for _, v := range i {
		if !filter(v) {
			list = append(list, v)
		}
	}

	return list
}

// Keep returns a new collection containing those elements where the predicate is true.
func (l Lists) Keep(filter func([]int) bool) Lists {
	if l == nil {
		return Lists(nil)
	}

	list := Lists{}

	for _, subList := range l {
		if filter(subList) {
			list = append(list, subList)
		}
	}

	return list
}

// Keep returns a new collection containing those elements where the predicate is true.
func (s Strings) Keep(filter func(string) bool) Strings {
	if s == nil {
		return Strings(nil)
	}

	list := Strings{}

	for _, v := range s {
		if filter(v) {
			list = append(list, v)
		}
	}

	return list
}
