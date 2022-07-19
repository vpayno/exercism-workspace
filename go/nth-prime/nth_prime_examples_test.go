package prime

import (
	"fmt"
)

func ExampleNth() {
	cases := []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

	for _, i := range cases {
		p, e := Nth(i)
		fmt.Printf("%d: %d:%v\n", i, p, e)
	}
	// Output:
	// 0: 0:the nth prime has to be equal to or greater than 1
	// 1: 2:<nil>
	// 2: 3:<nil>
	// 3: 5:<nil>
	// 4: 7:<nil>
	// 5: 11:<nil>
	// 6: 13:<nil>
	// 7: 17:<nil>
	// 8: 19:<nil>
	// 9: 23:<nil>
	// 10: 29:<nil>
}
