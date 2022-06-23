package diffsquares

import "fmt"

func ExampleSquareOfSum() {
	fmt.Println(SquareOfSum(10))
	fmt.Println(SquareOfSum(12345))
	fmt.Println(SquareOfSum(54321))
	// Output:
	// 3025
	// 5807306426319225
	// 2176842579255607808
}

func ExampleSumOfSquares() {
	fmt.Println(SumOfSquares(10))
	fmt.Println(SumOfSquares(12345))
	fmt.Println(SumOfSquares(54321))
	// Output:
	// 385
	// 627198189445
	// 53431086633961
}

func ExampleDifference() {
	fmt.Println(Difference(10))
	fmt.Println(Difference(12345))
	fmt.Println(Difference(54321))
	// Output:
	// 2640
	// 5806679228129780
	// 2176789148168973847
}
