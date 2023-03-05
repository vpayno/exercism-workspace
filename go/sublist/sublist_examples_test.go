package sublist

import (
	"fmt"
)

func ExampleSublist() {
	l1 := []int{1, 2, 3}
	l2 := []int{1, 2, 3}
	fmt.Println(Sublist(l1, l2))

	l1 = []int{1, 2, 3}
	l2 = []int{1, 3, 2}
	fmt.Println(Sublist(l1, l2))

	l1 = []int{1, 2, 3, 4, 5}
	l2 = []int{2, 3, 4}
	fmt.Println(Sublist(l1, l2))

	l1 = []int{2, 3, 4}
	l2 = []int{1, 2, 3, 4, 5}
	fmt.Println(Sublist(l1, l2))
	// Output:
	// equal
	// unequal
	// superlist
	// sublist
}
