package allergies

import "fmt"

func ExampleAllergicTo() {
	cases := map[uint]string{
		0b00000001: "eggs",
		0b00000010: "peanuts",
		0b00000100: "shellfish",
		0b00001000: "strawberries",
		0b00010000: "tomatoes",
		0b00100000: "chocolate",
		0b01000000: "pollen",
		0b10000000: "cats",
	}

	// ugly trick to sort the output
	flags := []uint{
		eggs,
		peanuts,
		shellfish,
		strawberries,
		tomatoes,
		chocolate,
		pollen,
		cats,
	}

	for _, flag := range flags {
		name := cases[flag]
		fmt.Printf("alergic to %q: %v\n", allergyNames[flag], AllergicTo(flag, name))
	}
	// Output:
	// alergic to "eggs": true
	// alergic to "peanuts": true
	// alergic to "shellfish": true
	// alergic to "strawberries": true
	// alergic to "tomatoes": true
	// alergic to "chocolate": true
	// alergic to "pollen": true
	// alergic to "cats": true
}

func ExampleAllergies() {
	flags := []uint{
		0b11111111,
	}

	for _, flag := range flags {
		fmt.Printf("%#v\n", Allergies(flag))
	}
	// Output:
	// []string{"eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"}
}
