// Package phonenumber used to clean up NANP (North American Numbering Plan) phone numbers.
package phonenumber

import (
	"errors"
	"regexp"
)

// ErrNumOfDigits is an error used when the phone number has less than 10 digits.
var ErrNumOfDigits = errors.New("incorrect number of digits")

// ErrElevenNotStartWithOne is an error used when the phone number has 11 digits and it doesn't start with one.
var ErrElevenNotStartWithOne = errors.New("11 digits must start with 1")

// ErrTooManyNumbers is an error used when the phone number has more than 11 digits.
var ErrTooManyNumbers = errors.New("more than 11 digits")

// ErrContainsLetters is an error used when the phone number has letters in it.
var ErrContainsLetters = errors.New("letters not permitted")

// ErrContainsPunctuations is an error used when the phone number has punctuation in it.
var ErrContainsPunctuations = errors.New("punctuations not permitted")

// ErrAreaCodeStartsWithZero is an error used when area codes start with zero.
var ErrAreaCodeStartsWithZero = errors.New("area code cannot start with zero")

// ErrAreaCodeStartsWithOne is an error used when area codes start with one.
var ErrAreaCodeStartsWithOne = errors.New("area code cannot start with one")

// ErrExchangeCodeStartsWithZero is an error used when exchange codes start with zero.
var ErrExchangeCodeStartsWithZero = errors.New("exchange code cannot start with zero")

// ErrExchangeCodeStartsWithOne is an error used when exchange codes start with one.
var ErrExchangeCodeStartsWithOne = errors.New("exchange code cannot start with one")

// ValidateInput returns an error if the phone number has invalid data in it.
func ValidateInput(phoneNumber string) error {
	// Check the string for invalid characters.
	// Pointless since we can easily just remove them.
	reStrPunct := `[\]\[\|:;><,?/\\"'!@#$%&*^]`
	match, e := regexp.MatchString(reStrPunct, phoneNumber)
	if e != nil {
		panic(e)
	}
	if match {
		return ErrContainsPunctuations
	}

	// Check to see if the phone number has letters in it.
	reStrLetters := `[[:alpha:]]`
	match, e = regexp.MatchString(reStrLetters, phoneNumber)
	if e != nil {
		panic(e)
	}
	if match {
		return ErrContainsLetters
	}

	// Clean up the string.
	reStr := `([[:space:]]|[[:punct:]]|[[:alpha:]]|[[:cntrl:]])`
	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	digits := re.ReplaceAllString(phoneNumber, ``)

	// Check the lenght of the remaining string.
	if len(digits) < 10 {
		return ErrNumOfDigits
	}
	if len(digits) > 11 {
		return ErrTooManyNumbers
	}

	// If it's an eleven digit number, make sure it starts with 1.
	if len(digits) == 11 && string(digits[0]) != "1" {
		return ErrElevenNotStartWithOne
	}

	// Check the starting digit of the area code.
	reStr = `^[[:digit:]]?([[:digit:]])[[:digit:]]{9}$`
	re, e = regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	digit := re.ReplaceAllString(digits, `$1`)
	if digit == "0" {
		return ErrAreaCodeStartsWithZero
	}
	if digit == "1" {
		return ErrAreaCodeStartsWithOne
	}

	// Check the starting digit of the exchange code.
	reStr = `^[[:digit:]]?[[:digit:]]{3}([[:digit:]])[[:digit:]]{6}$`
	re, e = regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	digit = re.ReplaceAllString(digits, `$1`)
	if digit == "0" {
		return ErrExchangeCodeStartsWithZero
	}
	if digit == "1" {
		return ErrExchangeCodeStartsWithOne
	}

	// No errors found.
	return nil
}

// Number returns just the digits of the passed phone number.
func Number(phoneNumber string) (string, error) {
	// Validate the input.
	eVal := ValidateInput(phoneNumber)
	if eVal != nil {
		return "", eVal
	}

	// Extract all the digits from the number.
	reStr := `([[:space:]]|[[:punct:]]|[[:alpha:]]|[[:cntrl:]])`
	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	digits := re.ReplaceAllString(phoneNumber, ``)

	// Return the 10-dgit number (minus the contry code).
	if len(digits) == 11 {
		return digits[1:], nil
	}

	// Return the 10-dgit number.
	return digits, nil
}

// AreaCode returns the area code from a phone number.
func AreaCode(phoneNumber string) (string, error) {
	// Get the digits from the input and input validation.
	digits, eNum := Number(phoneNumber)
	if eNum != nil {
		return "", eNum
	}

	// Get the first digit from the area code.
	reStr := `^([[:digit:]]?)([[:digit:]]{3})([[:digit:]]{7})$`
	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	areaCode := re.ReplaceAllString(digits, `$2`)

	// Return the area code without an error.
	return areaCode, nil
}

// Format returns a pretty phone number.
func Format(phoneNumber string) (string, error) {
	// Get the digits from the input and input validation.
	digits, eNum := Number(phoneNumber)
	if eNum != nil {
		return "", eNum
	}

	// Get the phone number groups and format the number.
	reStr := `^([[:digit:]]?)([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{4})$`
	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}
	fmtStr := re.ReplaceAllString(digits, `(${2}) ${3}-${4}`)

	// Return the formatted string without an error code.
	return fmtStr, nil
}
