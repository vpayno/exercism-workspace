package raindrops

import (
	"fmt"
)

func ExampleConvert() {
	rain := []int{1, 3, 5, 6, 7, 8, 15, 35, 105}
	for _, drop := range rain {
		fmt.Println(Convert(drop))
	}
	// Output:
	// 1
	// Pling
	// Plang
	// Pling
	// Plong
	// 8
	// PlingPlang
	// PlangPlong
	// PlingPlangPlong
}
