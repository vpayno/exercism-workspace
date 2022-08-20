// Package cryptosquare implements the classic method of compsing secret messages using a square code.
package cryptosquare

import (
	"fmt"
	"regexp"
	"strings"
)

// Enable printing in Encode() to debug the input and outputs from the different functions.
var debugMode = false

// Encode returns a crypto square encoded string.
func Encode(plain string) string {
	if plain == "" {
		return ""
	}

	if debugMode {
		fmt.Printf("plain: %q\n", plain)
	}

	normalizedText := NormalizeText(plain)

	if debugMode {
		fmt.Printf("plain: %q\n", normalizedText)
	}

	plainTokens := GetTokens(normalizedText)

	if debugMode {
		fmt.Printf("plainTokens: %#v\n", plainTokens)
	}

	encodedTokens := EncodeTokens(plainTokens)

	if debugMode {
		fmt.Printf("encodedTokens: %#v\n", encodedTokens)
	}

	cipher := strings.Join(encodedTokens, " ")

	return cipher
}

// NormalizeText returns a normalized string.
// - The spaces and punctuation are removed from the English text.
// - The message is down-cased.
func NormalizeText(text string) string {
	if text == "" {
		return ""
	}

	var output string

	reStr := `[[:^alnum:]]+`
	re, err := regexp.Compile(reStr)
	if err != nil {
		panic(err)
	}

	// If it's not A-Z, a-z or 0-9, replace it with an empty string.
	output = re.ReplaceAllString(text, "")

	output = strings.ToLower(output)

	return output
}

// GetSquareDimmensions returns the dimensions of the square to use.
func GetSquareDimmensions(text string) (row, col int) {
	size := len(text)

	if size == 0 {
		return
	}

	if size == 1 {
		row, col = 1, 1
		return
	}

	for c := 1; c <= size; c++ {
		for r := 1; r < size; r++ {
			if r*c >= size && c >= r && c-r <= 1 {
				row, col = r, c
				return
			}
		}
	}

	return
}

// GetTokens returns a string of tokens used to create the plain text "square".
func GetTokens(text string) []string {
	if text == "" {
		return []string{}
	}

	row, col := GetSquareDimmensions(NormalizeText(text))

	tokens := []string{}
	var token strings.Builder
	var count int

	for _, char := range text {
		count++
		token.WriteString(string(char))

		// Write a token to the slice.
		if count == col {
			tokens = append(tokens, token.String())
			token.Reset()
			count = 0
		}
	}

	// Prevent empty tokens from being captured.
	if len(token.String()) > 0 {
		tokens = append(tokens, token.String())
	}

	// Count can be zero or larger than col.
	// Catch incomplete tokens and add whitespace padd them.
	if count > 0 && count < col {
		tokens[row-1] += strings.Repeat(" ", col-count)
	}

	return tokens
}

// EncodeTokens returns the encoded "square".
func EncodeTokens(tokens []string) []string {
	if len(tokens) == 0 {
		return []string{}
	}

	var sb strings.Builder
	cipher := []string{}

	// col <= len because we need to capture incomplete tokens.
	for col := 0; col <= len(tokens); col++ {
		for _, row := range tokens {
			if col < len(row) {
				sb.WriteString(string(row[col]))
			}
		}

		// To prevent from ending with an empty token.
		// Write a token to the slice.
		if len(sb.String()) > 0 {
			cipher = append(cipher, sb.String())
		}
		sb.Reset()
	}

	return cipher
}
