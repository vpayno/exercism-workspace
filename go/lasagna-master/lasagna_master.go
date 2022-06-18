package lasagna

// PreparationTime returns the estimate for the total preparation time based on the number of layers as an `int`.
// Accepts a slice of layers as a `[]string` and the average preparation time per layer in minutes as an `int`.
func PreparationTime(layers []string, avgPrepTime int) int {
	if avgPrepTime <= 0 {
		avgPrepTime = 2
	}

	return len(layers) * avgPrepTime
}

// Quantities returns two values of noodles as an `int` and sauce as a `float64`.
// Accepts a slice of layers as parameter as a `[]string`.
func Quantities(layers []string) (int, float64) {
	var noodles int
	var sauce float64

	for _, layer := range layers {
		if layer == "noodles" {
			noodles += 50 // grams
		} else if layer == "sauce" {
			sauce += 0.2 // liters
		}
	}

	return noodles, sauce
}

// AddSecretIngredient passes `MyList` by reference.
// Accepts two slices of ingredients of type `[]string`.
func AddSecretIngredient(friendList []string, myList []string) {
	if myList[len(myList)-1] == "?" {
		myList[len(myList)-1] = friendList[len(friendList)-1]
	} else {
		panic("You already know the secret ingredient!")
	}
}

// ScaleRecipe returns a slice of `float64` of the amounts needed for the desired number of portions.
// Accepts a slice of `float64` amounts needed for 2 portions and the number of portions, `int`, you want to cook.
func ScaleRecipe(quantities []float64, portions int) []float64 {
	singles, newQuantities := []float64{}, []float64{}

	if portions == 2 || portions < 0 {
		newQuantities = quantities
	} else {
		// These could be merged into a single loop and the dedicated singles slice isn't needed.
		for _, quantity := range quantities {
			singles = append(singles, quantity/2.0)
		}

		if portions == 1 {
			newQuantities = singles
		} else {
			for _, quantity := range singles {
				newQuantities = append(newQuantities, quantity*float64(portions))
			}
		}
	}

	return newQuantities
}
