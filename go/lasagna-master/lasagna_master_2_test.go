package lasagna

import (
	"fmt"
)

func ExamplePreparationTime() {
	layers := []string{"sauce", "noodles", "sauce", "meat", "mozzarella", "noodles"}

	fmt.Println(PreparationTime(layers, 3))
	fmt.Println(PreparationTime(layers, 0))
	// Output:
	// 18
	// 12
}

func ExampleQuantities() {
	layers := []string{"sauce", "noodles", "sauce", "meat", "mozzarella", "noodles"}

	noodles, sauce := Quantities(layers)
	fmt.Printf("%d, %.1f\n", noodles, sauce)
	// Output:
	// 100, 0.4
}

func ExampleAddSecretIngredient() {
	friendsList := []string{"noodles", "sauce", "mozzarella", "kampot pepper"}
	myList := []string{"noodles", "meat", "sauce", "mozzarella", "?"}

	AddSecretIngredient(friendsList, myList)
	fmt.Printf("%#v\n", myList)
	// Output:
	// []string{"noodles", "meat", "sauce", "mozzarella", "kampot pepper"}
}

func ExampleScaleRecipe() {
	quantities := []float64{1.2, 3.6, 10.5}

	fmt.Println(ScaleRecipe(quantities, 0))
	fmt.Println(ScaleRecipe(quantities, 1))
	fmt.Println(ScaleRecipe(quantities, 2))
	fmt.Println(ScaleRecipe(quantities, 3))
	fmt.Println(ScaleRecipe(quantities, 4))
	// Output:
	// [0 0 0]
	// [0.6 1.8 5.25]
	// [1.2 3.6 10.5]
	// [1.7999999999999998 5.4 15.75]
	// [2.4 7.2 21]
}
