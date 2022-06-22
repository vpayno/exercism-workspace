package purchase

import (
	"fmt"
)

func ExampleNeedsLicense() {
	fmt.Println(NeedsLicense("car"))
	fmt.Println(NeedsLicense("bike"))
	// Output:
	// true
	// false
}

func ExampleChooseVehicle() {
	fmt.Println(ChooseVehicle("Wuling Hongguang", "Toyota Corolla"))
	fmt.Println(ChooseVehicle("Volkswagen Beetle", "Volkswagen Golf"))
	// Output:
	// Toyota Corolla is clearly the better choice.
	// Volkswagen Beetle is clearly the better choice.
}

func ExampleCalculateResellPrice() {
	fmt.Println(CalculateResellPrice(1000, 1))
	fmt.Println(CalculateResellPrice(1000, 5))
	fmt.Println(CalculateResellPrice(1000, 15))
	// Output:
	// 800
	// 700
	// 500
}
