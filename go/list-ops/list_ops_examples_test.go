package listops

import (
	"fmt"
)

func ExampleFoldl() {
	f := func(x, y int) int { return x * y }
	i := 5
	list := IntList{1, 2, 3, 4}

	fmt.Println(list.Foldl(f, i))
	// Output:
	// 120
}

func ExampleFoldr() {
	f := func(x, y int) int { return x * y }
	i := 5
	list := IntList{1, 2, 3, 4}

	fmt.Println(list.Foldr(f, i))
	// Output:
	// 120
}

func ExampleFilter() {
	f := func(n int) bool { return n%2 == 0 }
	list := IntList{1, 2, 3, 4}

	fmt.Println(list.Filter(f))
	// Output:
	// [2 4]
}

func ExampleMap() {
	f := func(x int) int { return x + 1 }
	list := IntList{1, 2, 3, 4}

	fmt.Println(list.Map(f))
	// Output:
	// [2 3 4 5]
}

func ExampleLen() {
	list := IntList{1, 2, 3, 4}

	fmt.Println(list.Length())
	// Output:
	// 4
}

func ExampleReverse() {
	list := IntList{1, 2, 3, 4}

	fmt.Println(list.Reverse())
	// Output:
	// [4 3 2 1]
}

func ExampleAppend() {
	list1 := IntList{1, 2, 3, 4}
	list2 := IntList{5, 6, 7, 8}

	fmt.Println(list1.Append(list2))
	// Output:
	// [1 2 3 4 5 6 7 8]
}

func ExampleConcat() {
	list1 := IntList{1, 2, 3, 4}
	list2 := []IntList{IntList{5}, IntList{6, 7}, IntList{}, IntList{8, 9}}

	fmt.Println(list1.Concat(list2))
	// Output:
	// [1 2 3 4 5 6 7 8 9]
}
