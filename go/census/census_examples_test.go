package census

import (
	"fmt"
)

func ExampleNewResident() {
	name := "Matthew Sanabria"
	age := 29
	address := map[string]string{"street": "Main St."}

	fmt.Println(NewResident(name, age, address))
	// Output:
	// &{Matthew Sanabria 29 map[street:Main St.]}
}

func ExampleHasRequiredInfo() {
	name := "Matthew Sanabria"
	age := 0
	address := make(map[string]string)

	resident := NewResident(name, age, address)

	fmt.Println(resident.HasRequiredInfo())
	// Output:
	// false
}

func ExampleDelete() {
	name := "Matthew Sanabria"
	age := 29
	address := map[string]string{"street": "Main St."}

	resident := NewResident(name, age, address)

	fmt.Printf("%#v\n", resident)
	resident.Delete()
	fmt.Printf("%#v\n", resident)
	// Output:
	// &census.Resident{Name:"Matthew Sanabria", Age:29, Address:map[string]string{"street":"Main St."}}
	// &census.Resident{Name:"", Age:0, Address:map[string]string(nil)}
}

func ExampleCount() {
	name1 := "Matthew Sanabria"
	age1 := 29
	address1 := map[string]string{"street": "Main St."}

	resident1 := NewResident(name1, age1, address1)

	name2 := "Rob Pike"
	age2 := 0
	address2 := map[string]string{}

	resident2 := NewResident(name2, age2, address2)

	residents := []*Resident{resident1, resident2}

	fmt.Println(Count(residents))
	// Output:
	// 1
}
