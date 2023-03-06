package resistorcolortrio

import (
	"fmt"
	"strings"
)

// Adding this helper function to reduce the deprecated noise.
func toTitleCase(text string) string {
	// strings.Title() is deprecated
	result := strings.Title(text)

	// You can't download modules or run `go mod tidy` in the Exercism test environment.
	// transform := cases.Title(language.English)
	// result := transform.String(text)

	return result
}

func ExampleColor_String() {
	var color Color

	// Starting with Undefined instead of ColorMin since I want to test it as well.
	for color = Undefined; color <= ColorMax; color++ {
		name := toTitleCase(color.String())
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
		name := toTitleCase(color.String())
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

func ExampleMetricPrefix_String() {
	var metricPrefix MetricPrefix

	// Starting with NoPrefix instead of MetricPrefixMin since I want to test it as well.
	for metricPrefix = NoPrefix; metricPrefix <= MetricPrefixMax; metricPrefix += 3 {
		name := toTitleCase(metricPrefix.String())
		value := metricPrefix.String()

		// Adding square brackets because NoPrefix is empty.
		fmt.Printf("[%s] is [%s]\n", name, value)
	}

	// Output:
	// [] is []
	// [Kilo] is [kilo]
	// [Mega] is [mega]
	// [Giga] is [giga]
}

func ExampleMetricPrefix_Int() {
	var metricPrefix MetricPrefix

	// Starting with NoPrefix instead of MetricPrefixMin since I want to test it as well.
	for metricPrefix = NoPrefix; metricPrefix <= MetricPrefixMax; metricPrefix += 3 {
		name := toTitleCase(metricPrefix.String())
		value := metricPrefix.Int()

		// Adding square brackets because NoPrefix is empty.
		fmt.Printf("[%s] is [%d]\n", name, value)
	}

	// Output:
	// [] is [0]
	// [Kilo] is [3]
	// [Mega] is [6]
	// [Giga] is [9]
}

func ExampleMetricPrefix_Magnitude() {
	var metricPrefix MetricPrefix

	// Starting with NoPrefix instead of MetricPrefixMin since I want to test it as well.
	for metricPrefix = NoPrefix; metricPrefix <= MetricPrefixMax; metricPrefix += 3 {
		name := toTitleCase(metricPrefix.String())
		value := metricPrefix.Magnitude()

		// Adding square brackets because NoPrefix is empty.
		fmt.Printf("[%s] is [%d]\n", name, value)
	}

	// Output:
	// [] is [1]
	// [Kilo] is [1000]
	// [Mega] is [1000000]
	// [Giga] is [1000000000]
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

func ExampleValue() {
	// not enough bands
	bands := []string{
		"brown",
	}
	fmt.Printf("The resistor value for %v is %d\n", bands, Value(bands))

	// two bands
	bands = []string{
		"brown",
		"green",
	}
	fmt.Printf("The resistor value for %v is %d\n", bands, Value(bands))

	// extra bands
	bands = []string{
		"brown",
		"green",
		"violet",
	}
	fmt.Printf("The resistor value for %v is %d\n", bands, Value(bands))
	// Output:
	// The resistor value for [brown] is -1
	// The resistor value for [brown green] is 15
	// The resistor value for [brown green violet] is 15
}

func ExampleLabel() {
	// not enough bands
	bands := []string{
		"orange",
	}
	fmt.Printf("The resistor label for %v is %s\n", bands, Label(bands))

	// two bands
	bands = []string{
		"orange",
		"orange",
	}
	fmt.Printf("The resistor label for %v is %s\n", bands, Label(bands))

	// ^0 .. ^9
	bands = []string{
		"orange",
		"orange",
		"",
	}

	for _, color := range Colors() {
		bands[2] = color
		fmt.Printf("The resistor label for %v is %s\n", bands, Label(bands))
	}

	// Output:
	// The resistor label for [orange] is -1 ohms
	// The resistor label for [orange orange] is -1 ohms
	// The resistor label for [orange orange black] is 33 ohms
	// The resistor label for [orange orange brown] is 330 ohms
	// The resistor label for [orange orange red] is 3 kiloohms
	// The resistor label for [orange orange orange] is 33 kiloohms
	// The resistor label for [orange orange yellow] is 330 kiloohms
	// The resistor label for [orange orange green] is 3 megaohms
	// The resistor label for [orange orange blue] is 33 megaohms
	// The resistor label for [orange orange violet] is 330 megaohms
	// The resistor label for [orange orange grey] is 3 gigaohms
	// The resistor label for [orange orange white] is 33 gigaohms
}
