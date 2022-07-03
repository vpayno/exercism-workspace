package darts

import (
	"fmt"
)

func ExampleScore() {
	fmt.Printf("score for (%d, %d): %d\n", 12, 12, Score(12, 12))
	fmt.Printf("score for (%d, %d): %d\n", 0, 0, Score(0, 0))
	fmt.Printf("score for (%d, %d): %d\n", 2, 2, Score(2, 2))
	fmt.Printf("score for (%d, %d): %d\n", 7, 7, Score(7, 7))
	// Output:
	// score for (12, 12): 0
	// score for (0, 0): 10
	// score for (2, 2): 5
	// score for (7, 7): 1
}
