package birdwatcher

import (
	"fmt"
)

func ExampleTotalBirdCount() {
	birdsPerDay := []int{2, 5, 0, 7, 4, 1, 3, 0, 2, 5, 0, 1, 3, 1}
	fmt.Println(TotalBirdCount(birdsPerDay))
	// Output:
	// 34
}

func ExampleBirdsInWeek() {
	birdsPerDay := []int{2, 5, 0, 7, 4, 1, 3, 0, 2, 5, 0, 1, 3, 1}
	fmt.Println(BirdsInWeek(birdsPerDay, 2))
	// Output:
	// 12
}

func ExampleFixBirdCountLog() {
	birdsPerDay := []int{2, 5, 0, 7, 4, 1}
	fmt.Println(FixBirdCountLog(birdsPerDay))
	// Output:
	// [3 5 1 7 5 1]
}
