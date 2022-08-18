// Package rotationalcipher is used to encrypt data.
package rotationalcipher

import (
	"bytes"
	"unicode"
)

// RotationalCipher returns a cipher text after applying a rotational cipher to a plain text input.
func RotationalCipher(plain string, shiftKey int) string {
	if len(plain) == 0 {
		return ""
	}

	var cipher bytes.Buffer

	for _, char := range plain {
		if !unicode.IsLower(char) && !unicode.IsUpper(char) {
			cipher.WriteString(string(char))
		} else {
			cipher.WriteString(string(shiftChar(char, shiftKey)))
		}
	}

	return cipher.String()
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

/*
	=== string concat vs bytes.Buffer ===

	name                old time/op    new time/op    delta
	RotationalCipher-4    3.61µs ± 0%    4.01µs ± 0%   ~     (p=1.000 n=1+1)

	name                old alloc/op   new alloc/op   delta
	RotationalCipher-4      680B ± 0%      680B ± 0%   ~     (all equal)

	name                old allocs/op  new allocs/op  delta
	RotationalCipher-4      14.0 ± 0%      14.0 ± 0%   ~     (all equal)
*/
