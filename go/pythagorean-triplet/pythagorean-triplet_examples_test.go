package pythagorean

import (
	"fmt"
)

type testCase struct {
	min int
	max int
}

func ExampleSquare() {
	fmt.Printf("%d^2 = %d\n", -5, 25)
	fmt.Printf("%d^2 = %d\n", 0, 0)
	fmt.Printf("%d^2 = %d\n", 5, 25)

	// Output:
	// -5^2 = 25
	// 0^2 = 0
	// 5^2 = 25
}

func ExampleCheckPythagoreanTriplets() {
	fmt.Printf("%v\n", CheckPythagoreanTriplets(-1, -1, -1))
	fmt.Printf("%v\n", CheckPythagoreanTriplets(0, 0, 0))
	fmt.Printf("%v\n", CheckPythagoreanTriplets(1, 2, 3))
	fmt.Printf("%v\n", CheckPythagoreanTriplets(3, 2, 1))
	fmt.Printf("%v\n", CheckPythagoreanTriplets(3, 4, 5))
	// Output:
	// false
	// true
	// false
	// false
	// true
}

func ExampleTripletSum() {
	cases := []Triplet{
		Triplet{0, 0, 0},
		Triplet{1, 2, 3},
		Triplet{3, 4, 5},
	}

	for _, c := range cases {
		fmt.Printf("Sum(%v) = %d\n", c, TripletSum(c))
	}

	// Output:
	// Sum([0 0 0]) = 0
	// Sum([1 2 3]) = 6
	// Sum([3 4 5]) = 12
}

func ExampleRange() {
	cases := []testCase{
		{
			min: 10,
			max: 1,
		},
		{
			min: 1,
			max: 10,
		},
		{
			min: 11,
			max: 20,
		},
	}

	for _, c := range cases {
		triplets := Range(c.min, c.max)
		fmt.Printf("Range(%d, %d) = %v\n", c.min, c.max, triplets)
	}

	// Output:
	// Range(10, 1) = []
	// Range(1, 10) = [[3 4 5] [6 8 10]]
	// Range(11, 20) = [[12 16 20]]
}

func ExampleSum() {
	cases := []int{0, 180, 1000}

	for _, s := range cases {
		fmt.Printf("Sum(%d) => %v\n", s, Sum(s))
	}

	// Output:
	// Sum(0) => []
	// Sum(180) => [[18 80 82] [30 72 78] [45 60 75]]
	// Sum(1000) => [[200 375 425]]
}
