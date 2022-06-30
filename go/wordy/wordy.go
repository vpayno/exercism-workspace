// Package wordy parses and evaluates simple math problems.
package wordy

import (
	"math"
	"regexp"
	"strconv"
)

// Answer returns a result and error after parsing and evaluating a simple math
// problem.
func Answer(question string) (int, bool) {
	var result int
	var reStr string
	var e error

	var reStrings []string = []string{
		`^What is (-?[0-9]+)[?]`,
		`^What is (-?[0-9]+) ?(plus|minus|multiplied by|divided by) ?(-?[0-9]+)[?]$`,
		`^What is (-?[0-9]+) ?(plus|minus|multiplied by|divided by) ?(-?[0-9]+) ?(plus|minus|multiplied by|divided by) ?(-?[0-9]+)[?]$`,
		`^What is (-?[0-9]+) ?(raised to the) ?(-?[0-9]+)[a-z][a-z] power[?]$`,
	}

	for _, reStr = range reStrings {

		match, me := regexp.MatchString(reStr, question)

		if me != nil {
			panic(me)
		}

		if match {
			break
		}
	}

	re, e := regexp.Compile(reStr)
	if e != nil {
		panic(e)
	}

	s1 := re.ReplaceAllString(question, "$1")
	n1, e1 := strconv.Atoi(s1)
	if e1 != nil {
		return 0, false
	}

	s3 := re.ReplaceAllString(question, "$3")
	var n3 int
	var e3 error
	if s3 != "" {
		n3, e3 = strconv.Atoi(s3)
		if e3 != nil {
			return 0, false
		}
	}

	s2 := re.ReplaceAllString(question, "$2")
	switch s2 {
	case "":
		result = n1
	case "plus":
		result = n1 + n3
	case "minus":
		result = n1 - n3
	case "multiplied by":
		result = n1 * n3
	case "divided by":
		result = n1 / n3
	case "raised to the":
		result = int(math.Pow(float64(n1), float64(n3)))
	default:
		return 0, false
	}

	s5 := re.ReplaceAllString(question, "$5")
	var n5 int
	var e5 error
	if s5 != "" {
		n5, e5 = strconv.Atoi(s5)
		if e5 != nil {
			return 0, false
		}
	}

	s4 := re.ReplaceAllString(question, "$4")
	switch s4 {
	case "":
		return result, true
	case "plus":
		result += n5
	case "minus":
		result -= n5
	case "multiplied by":
		result *= n5
	case "divided by":
		result /= n5
	case "raised to the":
		result = int(math.Pow(float64(result), float64(n5)))
	default:
		return result, true
	}

	return result, true
}
