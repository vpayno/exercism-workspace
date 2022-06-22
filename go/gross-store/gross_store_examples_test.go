package gross

import (
	"fmt"
)

func ExampleUnits() {
	units := Units()
	fmt.Println(units)
	// Output:
	// map[dozen:12 great_gross:1728 gross:144 half_of_a_dozen:6 quarter_of_a_dozen:3 small_gross:120]
}

func ExampleNewBill() {
	bill := NewBill()
	fmt.Println(bill)
	// Output:
	// map[]
}

func ExampleAddItem() {
	bill := NewBill()
	units := Units()

	status := AddItem(bill, units, "carrot", "dozen")
	fmt.Println(status)

	status = AddItem(bill, units, "carrot", "pint")
	fmt.Println(status)
	// Output:
	// true
	// false
}

func ExampleRemoveItem() {
	units := Units()

	bill := NewBill()
	status := RemoveItem(bill, units, "carrot", "dozen")
	fmt.Println(status)

	bill = map[string]int{"carrot": 12, "grapes": 3}
	status = RemoveItem(bill, units, "carrot", "dozen")
	fmt.Println(status)
	// Output:
	// false
	// true
}

func ExampleGetItem() {
	bill := map[string]int{"carrot": 12, "grapes": 3}
	query := []string{"carrot", "apples"}

	for _, item := range query {
		value, found := GetItem(bill, item)
		fmt.Printf("%v, %v\n", value, found)
	}
	// Output:
	// 12, true
	// 0, false
}
