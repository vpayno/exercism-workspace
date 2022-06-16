package cars

import (
	"fmt"
)

func ExampleCalculateWorkingCarsPerHour() {
	fmt.Println(CalculateWorkingCarsPerHour(1547, 90))
	// Output:
	// 1392.3
}

func ExampleCalculateWorkingCarsPerMinute() {
	fmt.Println(CalculateWorkingCarsPerMinute(1105, 90))
	// Output:
	// 16
}

func ExampleCalculateCost() {
	fmt.Println(CalculateCost(37))
	// Output:
	// 355000
}
