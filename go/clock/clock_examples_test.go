package clock

import (
	"fmt"
)

var clock Clock = Clock{
	h: 20,
	m: 35,
}

func ExampleClock_Add() {
	fmt.Printf("%s + 00:%2d = %s\n", clock, 20, clock.Add(20))
	fmt.Printf("%s + 00:%2d = %s\n", clock, 40, clock.Add(40))
	// Output:
	// 20:35 + 00:20 = 20:55
	// 20:35 + 00:40 = 21:15
}

func ExampleClock_Subtract() {
	fmt.Printf("%s - 00:%2d = %s\n", clock, 20, clock.Subtract(20))
	fmt.Printf("%s - 00:%2d = %s\n", clock, 40, clock.Subtract(40))
	// Output:
	// 20:35 - 00:20 = 20:15
	// 20:35 - 00:40 = 19:55
}

func ExampleString() {
	fmt.Println(clock.String())
	// Output:
	// 20:35
}
