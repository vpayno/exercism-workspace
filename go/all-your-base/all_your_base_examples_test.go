package allyourbase

import (
	"fmt"
)

func ExampleConvertToBase() {
	numbers, _ := ConvertToBase(2, []int{1, 0, 1}, 10)

	fmt.Printf("base %d %v to base %d %v\n", 2, []int{1, 0, 1}, 10, numbers)
	// Output:
	// base 2 [1 0 1] to base 10 [5]
}

func ExamplemathPow() {
	fmt.Printf("%d = %d ^ %d\n", mathPow(2, 8), 2, 8)
	// Output:
	// 256 = 2 ^ 8
}

func ExampleConvertToBase10() {
	digits := []int{1, 0, 1}
	base := 2

	fmt.Printf("number: %#v, base: %d\n", digits, base)
	fmt.Printf("number: %#v, base: %d\n", ConvertToBase10(base, digits), 10)
	// Output:
	// number: []int{1, 0, 1}, base: 2
	// number: 5, base: 10
}

func ExampleConvertFromBase10() {
	digits := 5
	base := 10

	fmt.Printf("number: %#v, base: %d\n", digits, base)
	fmt.Printf("number: %#v, base: %d\n", ConvertFromBase10(2, digits), 2)
	// Output:
	// number: 5, base: 10
	// number: []int{1, 0, 1}, base: 2
}

func ExampleConvertStrToIntList() {
	s := "12345"
	l := ConvertStrToIntList(s)

	fmt.Printf("str: %q\nlist: %#v\n", s, l)
	// Output:
	// str: "12345"
	// list: []int{1, 2, 3, 4, 5}
}
