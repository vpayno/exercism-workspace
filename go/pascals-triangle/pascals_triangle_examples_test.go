package pascal

import (
	"fmt"
)

func ExampleFactorial() {
	numbers := []int{-1, 0, 5}

	for _, n := range numbers {
		f, e := Factorial(n)
		fmt.Printf("!%d = %d, %v\n", n, f, e)
	}
	// Output:
	// !-1 = 0, Factorial(n): n must be >= 0
	// !0 = 1, <nil>
	// !5 = 120, <nil>
}

type testCase struct {
	n int
	k int
}

func ExampleNChooseK() {
	cases := []testCase{
		{
			n: -1,
			k: -1,
		},
		{
			n: -1,
			k: 0,
		},
		{
			n: 0,
			k: 0,
		},
		{
			n: 6,
			k: 2,
		},
	}

	for _, c := range cases {
		r, e := NChooseK(c.n, c.k)
		fmt.Printf("C(%d, %d) = %d, %v\n", c.n, c.k, r, e)
	}
	// Output:
	// C(-1, -1) = 0, NChooseK(n, k): k must be >= 0
	// C(-1, 0) = 0, NChooseK(n, k): n must be >= k
	// C(0, 0) = 1, <nil>
	// C(6, 2) = 15, <nil>
}

func ExampleTriangle() {
	numbers := []int{0, 1, 2, 3, 4, 5, 6}

	for _, n := range numbers {
		fmt.Printf("%d: %#v\n", n, Triangle(n))
	}
	// Output:
	// 0: [][]int{}
	// 1: [][]int{[]int{1}}
	// 2: [][]int{[]int{1}, []int{1, 1}}
	// 3: [][]int{[]int{1}, []int{1, 1}, []int{1, 2, 1}}
	// 4: [][]int{[]int{1}, []int{1, 1}, []int{1, 2, 1}, []int{1, 3, 3, 1}}
	// 5: [][]int{[]int{1}, []int{1, 1}, []int{1, 2, 1}, []int{1, 3, 3, 1}, []int{1, 4, 6, 4, 1}}
	// 6: [][]int{[]int{1}, []int{1, 1}, []int{1, 2, 1}, []int{1, 3, 3, 1}, []int{1, 4, 6, 4, 1}, []int{1, 5, 10, 10, 5, 1}}
}
