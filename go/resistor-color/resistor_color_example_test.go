package resistorcolor

import (
	"fmt"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

func ExampleColor_String() {
	var color Color

	// Starting with Undefined instead of ColorMin since I want to test it as well.
	for color = Undefined; color <= ColorMax; color++ {
		// strings.Title() is deprecated
		// name := strings.Title(color.String())

		transform := cases.Title(language.English)
		name := transform.String(color.String())

		value := color.String()

		fmt.Printf("%s is %s\n", name, value)
	}

	// Output:
	// Undefined is undefined
	// Black is black
	// Brown is brown
	// Red is red
	// Orange is orange
	// Yellow is yellow
	// Green is green
	// Blue is blue
	// Violet is violet
	// Grey is grey
	// White is white
}

func ExampleColor_Int() {
	var color Color

	// Starting with Undefined instead of ColorMin since I want to test it as well.
	for color = Undefined; color <= ColorMax; color++ {
		// strings.Title() is deprecated
		// name := strings.Title(color.String())

		transform := cases.Title(language.English)
		name := transform.String(color.String())

		value := color.Int()

		fmt.Printf("%s is %d\n", name, value)
	}

	// Output:
	// Undefined is -1
	// Black is 0
	// Brown is 1
	// Red is 2
	// Orange is 3
	// Yellow is 4
	// Green is 5
	// Blue is 6
	// Violet is 7
	// Grey is 8
	// White is 9
}

func ExampleColors() {
	fmt.Printf("%v\n", Colors())

	// Output:
	// [black brown red orange yellow green blue violet grey white]
}

func ExampleColorCode() {
	var color Color

	// Starting with Undefined instead of ColorMin since I want to test it as well.
	for color = Undefined; color <= ColorMax; color++ {
		name := color.String()
		value := ColorCode(name)

		fmt.Printf("Resistor band color %s has a value of %d\n", name, value)
	}

	// Output:
	// Resistor band color undefined has a value of -1
	// Resistor band color black has a value of 0
	// Resistor band color brown has a value of 1
	// Resistor band color red has a value of 2
	// Resistor band color orange has a value of 3
	// Resistor band color yellow has a value of 4
	// Resistor band color green has a value of 5
	// Resistor band color blue has a value of 6
	// Resistor band color violet has a value of 7
	// Resistor band color grey has a value of 8
	// Resistor band color white has a value of 9
}
