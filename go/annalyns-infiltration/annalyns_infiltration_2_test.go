package annalyn

import (
	"fmt"
)

func ExampleCanFastAttack() {
	fmt.Println(CanFastAttack(true))
	// Output:
	// false
}

func ExampleCanSpy() {
	fmt.Println(CanSpy(false, true, false))
	// Output:
	// true
}

func ExampleCanSignalPrisoner() {
	fmt.Println(CanSignalPrisoner(false, true))
	// Output:
	// true
}

func ExampleCanFreePrisoner() {
	fmt.Println(CanFreePrisoner(false, true, false, false))
	// Output:
	// false
}
