// Package atbash implements the atbash ciper.
package atbash

import (
	"fmt"
	"strings"
	"unicode"
)

// Atbash returns a simple substitution cipher text.
// Ciphertext is written out in groups of fixed length, the traditional group
// size being 5 letters, leaving numbers unchanged, and punctuation is excluded.
// This is to make it harder to guess things based on word boundaries. All text
// will be encoded as lowercase letters.
func Atbash(plain string) string {
	if len(plain) == 0 {
		return ""
	}

	var cipher strings.Builder
	var count int

	for _, char := range plain {
		c, e := shiftChar(char)

		// ok to ignore the errors since we're dropping non-encodable characters
		if e != nil {
			continue
		}

		if count%5 == 0 && count != 0 {
			cipher.WriteString(" ")
		}

		count++

		cipher.WriteString(string(c))
	}

	return cipher.String()
}

func shiftChar(char rune) (rune, error) {
	if unicode.IsUpper(char) {
		char = unicode.ToLower(char)
	}

	offset := 97 - 1

	if unicode.IsNumber(char) {
		return char, nil
	}

	if unicode.IsLetter(char) {
		return rune(((offset + 26) - (int(char) - 1)) + offset), nil
	}

	return '\x00', fmt.Errorf("char, %q, is not encodable", char)
}
