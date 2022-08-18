// Package rotationalcipher is used to encrypt data.
package rotationalcipher

import "unicode"

// RotationalCipher retuns a cipher text after applying a rotational cipher to a plain text input.
func RotationalCipher(plain string, shiftKey int) string {
	if len(plain) == 0 {
		return ""
	}

	var cipher string

	for _, char := range plain {
		if !unicode.IsLower(char) && !unicode.IsUpper(char) {
			cipher += string(char)
		} else {
			cipher += string(shiftChar(char, shiftKey))
		}
	}

	return cipher
}

func shiftChar(char rune, shift int) rune {
	var offset int

	if unicode.IsLower(char) {
		offset = 97
	}

	if unicode.IsUpper(char) {
		offset = 65
	}

	return rune(((int(char) - offset + shift) % 26) + offset)
}
