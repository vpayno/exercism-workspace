package leap

import (
	"fmt"
)

func ExampleIsLeapYear() {
	years := []int{1996, 1997, 1900, 2000}

	for _, year := range years {
		fmt.Printf("%d: %v\n", year, IsLeapYear(year))
	}
	// Output:
	// 1996: true
	// 1997: false
	// 1900: false
	// 2000: true
}
