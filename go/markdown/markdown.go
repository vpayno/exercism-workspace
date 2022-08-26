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

	for {
		char := markdown[cursorPosition]

		if char == '#' {

			for char == '#' {
				headerTracker++
				cursorPosition++
				char = markdown[cursorPosition]
			}

			if headerTracker == 7 {
				html += fmt.Sprintf("<p>%s ", strings.Repeat("#", headerTracker))
			} else if headerEnd {
				html += "# "
				headerTracker--
			} else {
				html += fmt.Sprintf("<h%d>", headerTracker)
			}

			cursorPosition++

			continue
		}

		headerEnd = true

		if char == '*' && headerTracker == 0 && strings.Contains(markdown, "\n") {

			if listTracker == 0 {
				html += "<ul>"
			}

			listTracker++

			if !listOpened {
				html += "<li>"
				listOpened = true
			} else {
				html += string(char) + " "
			}

			cursorPosition += 2

			continue
		}

		if char == '\n' {

			if listOpened && strings.LastIndex(markdown, "\n") == cursorPosition && strings.LastIndex(markdown, "\n") > strings.LastIndex(markdown, "*") {
				html += "</li></ul><p>"
				listOpened = false
				listTracker = 0
			}

			if listTracker > 0 && listOpened {
				html += "</li>"
				listOpened = false
			}

			if headerTracker > 0 {
				html += fmt.Sprintf("</h%d>", headerTracker)
				headerTracker = 0
			}

			cursorPosition++

			continue
		}

		html += string(char)

		cursorPosition++
		if cursorPosition >= len(markdown) {
			break
		}
	}

	switch {
	case headerTracker == 7:
		return html + "</p>"
	case headerTracker > 0:
		return html + fmt.Sprintf("</h%d>", headerTracker)
	}

	if listTracker > 0 {
		return html + "</li></ul>"
	}

	if strings.Contains(html, "<p>") {
		return html + "</p>"
	}

	return "<p>" + html + "</p>"
}
