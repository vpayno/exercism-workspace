#!/usr/bin/env bash

# 1. Clean up whitespace.
# 2. Address all shellcheck (v0.8.0) issues.
# 3. Style clean up.
# 4. Add types.
# 5. Improve variable names and add comments.
# 6. Move code to functions and code improvements.
# 7. Make html an array.

declare line
declare -a html
declare inside_a_list

mark_bold_text()
{
	local -n __line="${1}"

	# Step: Check for bold text.
	if grep -q '__..*__' <<< "${__line}"; then
		__line="$(sed -E 's,__([^_]+)__,<strong>\1</strong>,g' <<< "${__line}")"
	fi
} # mark_bold_text()

mark_italic_text()
{
	local -n __line="${1}"

	# Step: Check for italic text.
	if grep -q '_..*_' <<< "${__line}"; then
		__line="$(sed -E 's,_([^_]+)_,<em>\1</em>,g' <<< "${__line}")"
	fi
} # mark_italic_text()

mark_heading_or_paragraph_text()
{
	local -n __line="${1}"
	local -n __html1="${2}"

	local -i heading_level    # was 'n'
	local heading             # was 'HEAD'

	heading_level="$(expr "${__line}" : "#\{1,\}")"

	if [[ ${heading_level} -gt 0 ]] && [[ 7 -gt ${heading_level} ]]; then

		heading="${__line:heading_level}"

		while [[ ${heading} == " "* ]]; do
			heading="${heading# }"
		done

		# Step: Add <h#> & </h#> around the heading entry.
		__html1+=( "<h${heading_level}>${heading}</h${heading_level}>" )

	else

		# Empty lines don't need to be wrapped in <p>|</p> tags.
		if [[ ${#__line} -gt 0 ]]; then
			# Step: Add paragraph elements around paragraphs.
			__html1+=( "<p>${__line}</p>" )
		fi

	fi
} # mark_heading_or_paragraph_text()

mark_list_text()
{
	local -n __line="${1}"
	local -n __html2="${2}"

	#
	# Step: Check for unordered lists.
	#

	if grep -q '^\*' 2> /dev/null <<< "${line}"; then

		#
		# Step: Found an unordered list, start the HTML for it.
		#

		if [[ ${inside_a_list:-no} != yes ]]; then
			__html2+=( "<ul>" )
			inside_a_list="yes"
		fi

		#
		# Step: Add <li> & </li> around list entry.
		#

		__html2+=( "<li>${line#??}</li>" )

	else

		if [[ ${inside_a_list:-no} == yes ]]; then
			__html2+=( "</ul>" )
			inside_a_list="no"
		fi

		# return 1 after closing a list
		return 1

	fi
} # mark_list_text()

while IFS= read -r line; do

	mark_bold_text "line"

	mark_italic_text "line"

	if ! mark_list_text "line" "html"; then
		mark_heading_or_paragraph_text "line" "html"
	fi

done < "${1}"  # {} around variables

#
# Step: If we end while processing a list, close it.
#

if [[ ${inside_a_list:-no} == yes ]]; then
	html+=( "</ul>" )
fi

#
# Step: Output the rendered HTML.
#

printf "%s" "${html[@]}"
printf "\n"
