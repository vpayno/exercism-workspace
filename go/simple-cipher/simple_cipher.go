// Package cipher is comprised of multiple cipher implementations.
package cipher

import (
	"regexp"
	"strings"
)

type shift struct {
	distance int
}

type vigenere struct {
	key string
}

// NewCaesar returns a Cipher.
func NewCaesar() Cipher {
	var cipher shift

	cipher.distance = 3

	return cipher
}

// NewShift returns a Cipher.
func NewShift(distance int) Cipher {
	if distance < -25 || distance == 0 || distance > 25 {
		return nil
	}

	var cipher shift

	cipher.distance = distance

	return cipher
}

// Encode returns a shift encoded string.
func (c shift) Encode(plain string) string {
	if plain == "" {
		return ""
	}

	offset := 97

	input := normalize(plain)

	var output strings.Builder

	for _, char := range input {
		letter := int(char) - offset + c.distance

		// Negative numbers need to rotate back to the end of the range.
		if letter < 0 {
			letter += 26
		}

		letter = (letter % 26) + offset
		output.WriteRune(rune(letter))
	}

	return output.String()
}

// Decode returns a shift decoded string.
func (c shift) Decode(cipher string) string {
	if cipher == "" {
		return ""
	}

	offset := 97

	input := cipher

	var output strings.Builder

	for _, char := range input {
		letter := int(char) - offset - c.distance

		// Negative numbers need to rotate back to the end of the range.
		if letter < 0 {
			letter += 26
		}

		letter = (letter % 26) + offset
		output.WriteRune(rune(letter))
	}

	return output.String()
}

// NewVigenere returns a Cipher.
func NewVigenere(key string) Cipher {
	if key == "" {
		return nil
	}

	reStr := `^a+$`
	match, err := regexp.MatchString(reStr, key)
	if err != nil {
		panic(err)
	}

	// a+ key not allowed
	if match {
		return nil
	}

	reStr = `^[a-z]+$`
	match, err = regexp.MatchString(reStr, key)

	if err != nil {
		panic(err)
	}

	// key doesn't consist of just a-z letters
	if !match {
		return nil
	}

	cipher := vigenere{
		key: key,
	}

	return cipher
}

// Encode returns a vigenere encoded string.
func (v vigenere) Encode(plain string) string {
	if plain == "" {
		return ""
	}

	input := normalize(plain)

	key := fixKey(v.key, len(input))

	var cipher strings.Builder

	for i, char := range key {
		offset := int(char) - 97
		target := int(input[i]) + offset

		// Chars above Z need to roll back to bottom of the range.
		if target > 122 {
			target -= 26
		}

		cipher.WriteRune(rune(target))
	}

	return cipher.String()
}

// Decode returns a vigenere decoded string.
func (v vigenere) Decode(cipher string) string {
	if cipher == "" {
		return ""
	}

	input := cipher

	key := fixKey(v.key, len(input))

	var plain strings.Builder

	for i, char := range key {
		offset := int(char) - 97
		target := int(input[i]) - offset

		// Chars below A need to roll back to top of the range.
		if target < 97 {
			target += 26
		}

		plain.WriteRune(rune(target))
	}

	return plain.String()
}

func normalize(text string) string {
	if text == "" {
		return ""
	}

	var output string

	reStr := `[[:^alpha:]]`
	re, err := regexp.Compile(reStr)
	if err != nil {
		panic(err)
	}

	output = re.ReplaceAllString(text, "")
	output = strings.ToLower(output)

	return output
}

func fixKey(oldKey string, size int) string {
	if size <= 0 {
		return ""
	}

	newKey := oldKey

	for len(newKey) < size {
		newKey += oldKey
	}

	newKey = newKey[:size]

	return newKey
}
