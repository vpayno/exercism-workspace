// Package reverse has one public method for reversing a string.
package reverse

// Reverse returns a reversed string.
func Reverse(input string) string {
	var output string

	for _, r := range input {
		output = string(r) + output
	}

	return output

}
