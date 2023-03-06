// Package resistorcolortrio helps users identify resistors using their color bands.
package resistorcolortrio

import (
	"fmt"
	"math"
	"strings"
)

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

// MetricPrefix type represents the metric prefix of our resistor value.
type MetricPrefix int

// Enum of MetricPrefixes
const (
	NoPrefix MetricPrefix = 3 * iota
	Kilo
	Mega
	Giga
)

// To make MetricPrefix lower and upper bound tests clearer, let's define constants.
// Kilo and Giga are at the lower and upper boundaries.
// All other MetricPrefixes should be between them.
const (
	MetricPrefixMin MetricPrefix = Kilo
	MetricPrefixMax              = Giga
)

// MetricPrefixNames maps MetrixPrefix to it's string representation.
var MetricPrefixNames = map[MetricPrefix]string{
	NoPrefix: "",
	Kilo:     "kilo",
	Mega:     "mega",
	Giga:     "giga",
}

// String implements the Stringer interface for MetricPrefix.
func (m MetricPrefix) String() string {
	if m >= MetricPrefixMin && m <= MetricPrefixMax {
		return MetricPrefixNames[m]
	}

	return MetricPrefixNames[NoPrefix]
}

// Int returns the integer representation of a MetricPrefix.
func (m MetricPrefix) Int() int {
	if m >= MetricPrefixMin && m <= MetricPrefixMax {
		return int(m)
	}

	return int(NoPrefix)
}

func (m MetricPrefix) Magnitude() int {
	return int(math.Pow(float64(10), float64(m.Int())))
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

// Value returns the resistance value of a resistor with a given colors.
func Value(colors []string) int {
	// Some light error checking without returning an error.
	// These are fast returns, in Go you check your corner cases first and do your
	// fast returns and then the happy path can exist unnested with complicated
	// error checking logic.
	// Returning -1 instead of 0, err
	// Note: one tests wants us to ignore extra bands
	if len(colors) < 2 {
		return -1
	}

	var value int

	// the first band is in the 10s position
	value += ColorCode(colors[0]) * 10

	// the second band is in the 1s position
	value += ColorCode(colors[1])

	return value
}

// Unit returns the units for a given set of bands.
func Unit(value int) string {
	var unitPrefix string

	// Always start with the largest number first.
	switch {
	case value/Giga.Magnitude() != 0:
		unitPrefix = Giga.String()
	case value/Mega.Magnitude() != 0:
		unitPrefix = Mega.String()
	case value/Kilo.Magnitude() != 0:
		unitPrefix = Kilo.String()
	default:
		unitPrefix = ""
	}

	unit := unitPrefix + "ohms"

	return unit
}

// Label describes the resistance label given the colors of a resistor.
// The label is a string with a resistance value with an unit appended
// (e.g. "33 ohms", "470 kiloohms").
func Label(colors []string) string {
	if len(colors) < 3 {
		return "-1 ohms"
	}

	var value int

	// the first band is in the 10s position
	value += ColorCode(colors[0]) * 10

	// the second band is in the 1s position
	value += ColorCode(colors[1])

	// the third band is factor (^1 -> x10, ^2 -> x100, ...)
	value *= int(math.Pow(float64(10), float64(ColorCode(colors[2]))))

	// figure out what the MetricPrefix is before we remove one or more 1k from the value.
	unit := Unit(value)

	// factor out 1k chunks
	for value > 0 && value/1_000 != 0 {
		value /= 1_000
	}

	var sb strings.Builder

	_, e := sb.WriteString(fmt.Sprintf("%d", value))

	// Not sure how to get this to fail so it can be tested.
	if e != nil {
		return "-1 ohms"
	}

	_, e = sb.WriteString(" " + unit)

	// Not sure how to get this to fail so it can be tested.
	if e != nil {
		return "-1 ohms"
	}

	return sb.String()
}
