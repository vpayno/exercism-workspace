// Package resistorcolor duo helps users identify resistors using their color bands.
package resistorcolor

// Color type represents the value of a resistor's band.
type Color int

// Color constants used as an Enum. Starts with -1 for which is used as an
// undefined color.
const (
	Undefined Color = iota - 1
	Black
	Brown
	Red
	Orange
	Yellow
	Green
	Blue
	Violet
	Grey
	White
)

// To make Color lower and upper bound tests clearer, let's define constants.
// Black and White are at the lower and upper boundaries.
// All other colors should be between them.
const (
	ColorMin Color = Black
	ColorMax       = White
)

// ColorNames maps Color type to it's string representation.
var ColorNames = map[Color]string{
	Undefined: "undefined",
	Black:     "black",
	Brown:     "brown",
	Red:       "red",
	Orange:    "orange",
	Yellow:    "yellow",
	Green:     "green",
	Blue:      "blue",
	Violet:    "violet",
	Grey:      "grey",
	White:     "white",
}

// String implements the Stringer interface.
// Another way of getting the String equivalent of a Color.
// We're going to use both to help make this exercise interesting.
// You can also use a switch in here; But, since we have our min/max constants,
// this should be easier to maintain.
// This also allows us to provide a response for undefined colors without complicated
// error checking since this exercise lacks error returns on the functions being
// tested.
func (c Color) String() string {
	if c >= ColorMin && c <= ColorMax {
		return ColorNames[c]
	}

	return ColorNames[Undefined]
}

// Int returns the integer representation of a Color.
// Yes, we could just use int(Color); But, this is more fun.
func (c Color) Int() int {
	if c >= ColorMin && c <= ColorMax {
		return int(c)
	}

	return int(Undefined)
}

// Colors should return the list of all colors.
// They are limiting your implementation possibilities. Not sure why even bother
// having a function since the contents of it are very static.
// I don't wan't to use an array to store the color data, I'm going to use an Enum
// instead. Now to find a clever way of generating the data from an Enum type that
// isn't a type and it's just a bunch of constants.
func Colors() []string {
	colors := []string{}

	// You can't specify the type in the for loop, you have to do it outside.
	var color Color

	// Using int for our constants, lets us iterate over them like Enums were a
	// real type.
	for color = ColorMin; color <= ColorMax; color++ {
		colors = append(colors, color.String())
	}

	return colors
}

// ColorCode returns the resistance value of the given color.
// I guess instead of having a map[String]int{} to do the lookups, we have to
// search a []String{} array and find the element with that string and return the index.
// They really sucked the fun out of this function.
func ColorCode(color string) int {
	for value, name := range Colors() {
		if name == color {
			return value
		}
	}

	return Undefined.Int()
}
