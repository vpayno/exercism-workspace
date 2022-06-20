package parsinglogfiles

import (
	"regexp"
)

// IsValidLine returns true if the text starts with one of [TRC], [DBG], [INF], [WRN], [ERR], [FTL].
func IsValidLine(text string) bool {
	var regexpString string = `^\[(TRC|DBG|INF|WRN|ERR|FTL)\].*$`

	isMatch, error := regexp.MatchString(regexpString, text)

	if error != nil {
		panic(error)
	}

	return isMatch
}

// SplitLogLine returns a string slice of fields from the passed text.
func SplitLogLine(text string) []string {
	var regexpString string = `\b<[-~=*]*>\b`

	re, error := regexp.Compile(regexpString)

	if error != nil {
		panic(error)
	}

	tokens := re.Split(text, -1)

	return tokens
}

// CountQuotedPasswords returns the count of quoted passwords from the array of log lines.
func CountQuotedPasswords(lines []string) int {
	var count int
	var regexpString string = `(?i)".*password.*"`

	re, error := regexp.Compile(regexpString)

	if error != nil {
		panic(error)
	}

	for _, line := range lines {
		count += len(re.FindAllString(line, -1))
	}

	return count
}

// RemoveEndOfLineText returns a string without `end-of-line[0-9]+`.
func RemoveEndOfLineText(text string) string {
	var replacement string
	var regexpString string = `(?i)end-of-line[0-9]+`

	re, error := regexp.Compile(regexpString)

	if error != nil {
		panic(error)
	}

	replacement = re.ReplaceAllString(text, "")

	return replacement
}

// TagWithUserName returns a slice of strings with user mentions.
func TagWithUserName(lines []string) []string {
	var regexpString string = `^(.*User +\b)([A-Za-z][A-Za-z0-9]+)(\b.*)$`

	re, error := regexp.Compile(regexpString)

	if error != nil {
		panic(error)
	}

	for index, line := range lines {
		lines[index] = re.ReplaceAllString(line, `[USR] $2 $1$2$3`)
	}

	return lines
}
