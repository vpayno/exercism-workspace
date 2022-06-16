package lasagna

import (
	"fmt"
)

func ExampleRemainingOvenTime() {
	fmt.Println(RemainingOvenTime(30))
	// Output:
	// 10
}

func ExamplePreparationTime() {
	fmt.Println(PreparationTime(2))
	// Output:
	// 4
}

func ExampleElapsedTime() {
	fmt.Println(ElapsedTime(3, 20))
	// Output:
	// 26
}
