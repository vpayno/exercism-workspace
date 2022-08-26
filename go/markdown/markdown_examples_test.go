package markdown

import "fmt"

func ExampleRender() {
	markdown := `# Title

	summary

	## Heading1

	- list1
	- list2
	- list3

	## Heading2

	- [Site1](https://google.com/)
	`

	html := Render(markdown)
	fmt.Printf("markdown: %q\n    html: %q\n", markdown, html)
	// Output:
	// markdown: "# Title\n\n\tsummary\n\n\t## Heading1\n\n\t- list1\n\t- list2\n\t- list3\n\n\t## Heading2\n\n\t- [Site1](https://google.com/)\n\t"
	//     html: "<p><h1>Title</h1>\tsummary\t# Heading1</h1>\t- list1\t- list2\t- list3\t# Heading2</h1>\t- [Site1](https://google.com/)\t</p>"
}
