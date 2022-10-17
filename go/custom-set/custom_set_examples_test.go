package stringset

import "fmt"

func ExampleNew() {
	set := New()

	fmt.Printf("set: %s\n", set.String())
	// Output:
	// set: {}
}

func ExampleNewFromSlice() {
	slice := []string{"a", "b", "c"}
	set := NewFromSlice(slice)

	fmt.Printf("slice: %s\n", set.String())
	fmt.Printf("  set: %s\n", set.String())
	// Output:
	// slice: {"a", "b", "c"}
	//   set: {"a", "b", "c"}
}

func ExampleSet_IsEmpty() {
	s1 := New()

	slice := []string{"a", "b", "c"}
	s2 := NewFromSlice(slice)

	fmt.Printf("s1.IsEmpty(): %v\n", s1.IsEmpty())
	fmt.Printf("s2.IsEmpty(): %v\n", s2.IsEmpty())
	// Output:
	// s1.IsEmpty(): true
	// s2.IsEmpty(): false
}

func ExampleSet_Add() {
	s1 := New()

	s1.Add("a")
	fmt.Printf("s1.Add(a): %s\n", s1.String())

	s1.Add("b")
	fmt.Printf("s1.Add(b): %s\n", s1.String())

	s1.Add("c")
	fmt.Printf("s1.Add(c): %s\n", s1.String())
	// Output:
	// s1.Add(a): {"a"}
	// s1.Add(b): {"a", "b"}
	// s1.Add(c): {"a", "b", "c"}
}

func ExampleSet_Has() {
	slice := []string{"a", "b", "c"}
	s1 := NewFromSlice(slice)

	fmt.Printf("s1.Has(a): %v\n", s1.Has("a"))
	fmt.Printf("s1.Has(b): %v\n", s1.Has("b"))
	fmt.Printf("s1.Has(c): %v\n", s1.Has("c"))
	fmt.Printf("s1.Has(z): %v\n", s1.Has("z"))
	// Output:
	// s1.Has(a): true
	// s1.Has(b): true
	// s1.Has(c): true
	// s1.Has(z): false
}

func ExampleSubset() {
	slice1 := []string{"a", "b", "c"}
	slice2 := []string{"a", "c"}
	set1 := NewFromSlice(slice1)
	set2 := NewFromSlice(slice2)

	fmt.Printf("Subset(%s, %s): %v\n", set1, set2, Subset(set1, set2))
	// Output:
	// Subset({"a", "b", "c"}, {"a", "c"}): false
}

func ExampleDisjoint() {
	slice1 := []string{"a", "b", "c"}
	slice2 := []string{"c", "d", "e"}
	set1 := NewFromSlice(slice1)
	set2 := NewFromSlice(slice2)

	fmt.Printf("Disjoint(%s, %s): %v\n", set1, set2, Disjoint(set1, set2))

	slice1 = []string{"a", "b", "c"}
	slice2 = []string{"d", "e", "f"}
	set1 = NewFromSlice(slice1)
	set2 = NewFromSlice(slice2)

	fmt.Printf("Disjoint(%s, %s): %v\n", set1, set2, Disjoint(set1, set2))
	// Output:
	// Disjoint({"a", "b", "c"}, {"c", "d", "e"}): false
	// Disjoint({"a", "b", "c"}, {"d", "e", "f"}): true
}

func ExampleEqual() {
	slice1 := []string{"a", "b", "c"}
	set1 := NewFromSlice(slice1)

	slice2 := []string{"a", "b", "c"}
	set2 := NewFromSlice(slice2)

	fmt.Printf("Equal(%s, %s): %v\n", set1, set2, Equal(set1, set2))

	slice2 = []string{"a", "x", "c"}
	set2 = NewFromSlice(slice2)

	fmt.Printf("Equal(%s, %s): %v\n", set1, set2, Equal(set1, set2))
	// Output:
	// Equal({"a", "b", "c"}, {"a", "b", "c"}): true
	// Equal({"a", "b", "c"}, {"a", "c", "x"}): false
}

func ExampleIntersection() {
	slice1 := []string{"a", "b", "c"}
	slice2 := []string{"c", "d", "e"}
	set1 := NewFromSlice(slice1)
	set2 := NewFromSlice(slice2)

	fmt.Printf("Intersection(%s, %s): %s\n", set1, set2, Intersection(set1, set2))
	// Output:
	// Intersection({"a", "b", "c"}, {"c", "d", "e"}): {"c"}
}

func ExampleDifference() {
	slice1 := []string{"a", "b", "c"}
	slice2 := []string{"c", "d", "e"}
	set1 := NewFromSlice(slice1)
	set2 := NewFromSlice(slice2)

	fmt.Printf("Difference(%s, %s): %s\n", set1, set2, Difference(set1, set2))
	// Output:
	// Difference({"a", "b", "c"}, {"c", "d", "e"}): {"a", "b"}
}

func ExampleUnion() {
	slice1 := []string{"a", "b", "c"}
	slice2 := []string{"c", "d", "e"}
	set1 := NewFromSlice(slice1)
	set2 := NewFromSlice(slice2)

	fmt.Printf("Union(%s, %s): %s\n", set1, set2, Union(set1, set2))
	// Output:
	// Union({"a", "b", "c"}, {"c", "d", "e"}): {"a", "b", "c", "d", "e"}
}
