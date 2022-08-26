// Package markdown renders markdown into HTML.
package markdown

// implementation to refactor

import (
	"fmt"
	"strings"
)

/*
	1. Whitespace clean up.
	2. Use better variable names.
	3. Use strings.Builder for the html variable.
	4. Switch to a for loop with an exit condition.
	5. Switch if-else chains to switch statements.
*/

// Render translates markdown to HTML
func Render(input string) string {
	headerTracker := 0

	var html strings.Builder

	markdown := input

	markdown = strings.Replace(markdown, "__", "<strong>", 1)
	markdown = strings.Replace(markdown, "__", "</strong>", 1)
	markdown = strings.Replace(markdown, "_", "<em>", 1)
	markdown = strings.Replace(markdown, "_", "</em>", 1)

	cursorPosition := 0
	listTracker := 0
	listOpened := false
	headerEnd := false

	for cursorPosition < len(markdown) {

		char := markdown[cursorPosition]

		if char == '#' {

			for char == '#' {
				headerTracker++
				cursorPosition++
				char = markdown[cursorPosition]
			}

			switch {
			case headerTracker == 7:
				html.WriteString(fmt.Sprintf("<p>%s ", strings.Repeat("#", headerTracker)))

			case headerEnd:
				html.WriteString("# ")
				headerTracker--

			default:
				html.WriteString(fmt.Sprintf("<h%d>", headerTracker))
			}

			cursorPosition++

			continue
		}

		headerEnd = true

		if char == '*' && headerTracker == 0 && strings.Contains(markdown, "\n") {

			if listTracker == 0 {
				html.WriteString("<ul>")
			}

			listTracker++

			switch {
			case !listOpened:
				html.WriteString("<li>")
				listOpened = true

			default:
				html.WriteByte(char)
				html.WriteString(" ")
			}

			cursorPosition += 2

			continue
		}

		if char == '\n' {

			if listOpened && strings.LastIndex(markdown, "\n") == cursorPosition && strings.LastIndex(markdown, "\n") > strings.LastIndex(markdown, "*") {
				html.WriteString("</li></ul><p>")
				listOpened = false
				listTracker = 0
			}

			if listTracker > 0 && listOpened {
				html.WriteString("</li>")
				listOpened = false
			}

			if headerTracker > 0 {
				html.WriteString(fmt.Sprintf("</h%d>", headerTracker))
				headerTracker = 0
			}

			cursorPosition++

			continue
		}

		html.WriteByte(char)

		cursorPosition++
	}

	switch {
	case headerTracker == 7:
		html.WriteString("</p>")
		return html.String()

	case headerTracker > 0:
		html.WriteString(fmt.Sprintf("</h%d>", headerTracker))
		return html.String()
	}

	if listTracker > 0 {
		html.WriteString("</li></ul>")
		return html.String()
	}

	if strings.Contains(html.String(), "<p>") {
		html.WriteString("</p>")
		return html.String()
	}

	html.WriteString("</p>")
	return "<p>" + html.String()
}
