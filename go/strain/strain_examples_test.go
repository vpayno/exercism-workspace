package strain

import "fmt"

func ExampleInts_Keep() {
	list := Ints{1, 2, 3, 4, 5, 6, 7, 8, 9}
	f := func(n int) bool { return n%2 == 0 }

	fmt.Println(list.Keep(f))
	// Output:
	// [2 4 6 8]
}

func ExampleInts_Discard() {
	list := Ints{1, 2, 3, 4, 5, 6, 7, 8, 9}
	f := func(n int) bool { return n%2 == 0 }

	fmt.Println(list.Discard(f))
	// Output:
	// [1 3 5 7 9]
}

func ExampleLists_Keep() {
	list := Lists{
		[]int{1, 2, 3},
		[]int{4, 5, 6, 7},
		[]int{8, 9},
	}
	f := func(list []int) bool {
		for _, n := range list {
			if n == 5 {
				return true
			}
		}
		return false
	}

	fmt.Println(list.Keep(f))
	// Output:
	// [[4 5 6 7]]
}

func ExampleStrings_Keep() {
	list := Strings{"one", "two", "three", "four"}
	f := func(s string) bool { return len(s)%2 == 0 }

	fmt.Println(list.Keep(f))
	// Output:
	// [four]
}
