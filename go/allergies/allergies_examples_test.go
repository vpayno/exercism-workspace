package allergies

import "fmt"

func ExampleAllergicTo() {
	// ugly trick to sort the output
	flags := []allergy{
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
		fmt.Printf("alergic to %q: %v\n", allergyNames[flag], AllergicTo(flag, flag))
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
	flags := []allergy{
		0b11111111,
	}

	for _, flag := range flags {
		fmt.Printf("%#v\n", Allergies(flag))
	}
	// Output:
	// []string{"eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"}
}
