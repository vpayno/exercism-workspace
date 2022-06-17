package techpalace

import (
	"fmt"
	"strings"
)

// WelcomeMessage returns a welcome message for the customer.
func WelcomeMessage(customer string) string {
	return "Welcome to the Tech Palace, " + strings.ToUpper(customer)
}

// AddBorder adds a border to a welcome message.
func AddBorder(welcomeMsg string, numStarsPerLine int) string {
	var line string = strings.Repeat("*", numStarsPerLine)

	return fmt.Sprintf("%s\n%s\n%s", line, welcomeMsg, line)
}

// CleanupMessage cleans up an old marketing message.
func CleanupMessage(oldMsg string) string {
	var newMsg string

	newMsg = strings.ReplaceAll(oldMsg, "*", "")
	newMsg = strings.TrimSpace(newMsg)

	return newMsg
}
