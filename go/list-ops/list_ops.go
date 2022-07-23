// Package listops is a library of list utility functions.
package listops

// IntList is an abstraction of a list of integers which we can define methods on
type IntList []int

// Foldl returns the left to right reduced value using the passed function.
func (s IntList) Foldl(fn func(int, int) int, acc int) int {
	// fmt.Printf("s: %#v\n", s)

	for _, n := range s {
		acc = fn(acc, n)
	}

	return acc
}

// Foldl returns the right to left reduced value using the passed function.
func (s IntList) Foldr(fn func(int, int) int, acc int) int {
	// fmt.Printf("s: %#v\n", s)

	var r IntList = s.Reverse()

	for _, n := range r {
		acc = fn(n, acc)
	}

	return acc
}

// Filter returns list of all items for which predicate(item) is True.
func (s IntList) Filter(fn func(int) bool) IntList {
	// fmt.Printf("s: %#v\n", s)

	var r IntList = IntList{}

	for _, n := range s {
		if fn(n) {
			r = append(r, n)
		}
	}

	return r
}

// Length returns the length of the list.
func (s IntList) Length() int {
	// fmt.Printf("s: %#v\n", s)

	return len(s)
}

// Map returns a list of the results of applying function(item) on all items.
func (s IntList) Map(fn func(int) int) IntList {
	// fmt.Printf("s: %#v\n", s)

	var r IntList = IntList{}

	for _, n := range s {
		r = append(r, fn(n))
	}

	return r
}

// Reverse returns a reversed list.
func (s IntList) Reverse() IntList {
	// fmt.Printf("s: %#v\n", s)

	r := IntList{}

	for i, _ := range s {
		r = append(r, s[len(s)-1-i])
	}

	// fmt.Printf("r: %#v\n", r)

	return r
}

// Append returns an end-appended list.
func (s IntList) Append(lst IntList) IntList {
	// fmt.Printf("s: %#v\n", s)

	return append(s, lst...)
}

// Concat returns a flattened list from all the lists passed.
func (s IntList) Concat(lists []IntList) IntList {
	// fmt.Printf("s: %#v\n", s)

	r := s

	for _, l := range lists {
		for _, n := range l {
			r = append(r, n)
		}
	}

	return r
}
