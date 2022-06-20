package sorting

import (
	"fmt"
	"strconv"
)

// DescribeNumber should return a string describing the number.
func DescribeNumber(f float64) string {
	str := "This is the number"
	return fmt.Sprintf("%s %.1f", str, f)
}

// NumberBox struct method set interface.
type NumberBox interface {
	Number() int
}

// DescribeNumberBox should return a string describing the NumberBox.
func DescribeNumberBox(nb NumberBox) string {
	str := "This is a box containing the number"
	return fmt.Sprintf("%s %.1f", str, float64(nb.Number()))
}

// FancyNumber struct that holds a string number.
type FancyNumber struct {
	n string
}

// Value is a FancyNumber method.
func (i FancyNumber) Value() string {
	return i.n
}

// FancyNumberBox struct method set interface.
type FancyNumberBox interface {
	Value() string
}

// ExtractFancyNumber should return the integer value for a FancyNumber
// and 0 if any other FancyNumberBox is supplied.
func ExtractFancyNumber(fnb FancyNumberBox) int {
	i, e := strconv.Atoi(fnb.Value())

	if e != nil {
		return 0
	}

	return i
}

// DescribeFancyNumberBox should return a string describing the FancyNumberBox.
func DescribeFancyNumberBox(fnb FancyNumberBox) string {
	var f float64 = float64(ExtractFancyNumber(fnb))

	return fmt.Sprintf("This is a fancy box containing the number %.1f", f)
}

// DescribeAnything should return a string describing whatever it contains.
func DescribeAnything(i interface{}) string {
	switch v := i.(type) {
	case int:
		return DescribeNumber(float64(v))
	case float64:
		return DescribeNumber(v)
	case NumberBox:
		return DescribeNumberBox(v)
	case FancyNumberBox:
		return DescribeFancyNumberBox(v)
	default:
		return "Return to sender"
	}
}
