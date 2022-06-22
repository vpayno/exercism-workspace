package chance

import (
	"fmt"
)

func ExampleRollADie() {
	randNum := RollADie()
	fmt.Println(randNum <= 20)
	fmt.Println(1 <= randNum)
	// Output:
	// true
	// true
}

func ExampleGenerateWandEnergy() {
	randFloat := GenerateWandEnergy()
	fmt.Println(randFloat <= 12.0)
	fmt.Println(0.0 <= randFloat)
	// Output:
	// true
	// true
}

func ExampleShuffleAnimals() {
	fmt.Println(len(ShuffleAnimals()))
	// Output:
	// 8
}
