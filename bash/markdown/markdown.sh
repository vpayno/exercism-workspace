#!/usr/bin/env bash

# 1. Clean up whitespace.
# 2. Address all shellcheck (v0.8.0) issues.
# 3. Style clean up.
# 4. Add types.
# 5. Improve variable names and add comments.

declare orig
declare line
declare match_again         # was 'pre'
declare string_pre          # new & was 'one'
declare string_post         # was 'post'
declare string_to_bold      # new
declare inside_a_list
declare html  # was 'h'
declare string_filter       # was 'two'
declare -i heading_level    # was 'n'
declare heading             # was 'HEAD'

while IFS= read -r line; do

	#
	# Step: Checking for bold test.
	#

	while true; do

		# {} braces and double quotes
		orig="${line}"

		# {} around variables
		if [[ ${line} =~ ^(.+)__(.*) ]]; then

			# double quotes, breakup line
			match_again="${BASH_REMATCH[1]}"
			string_post="${BASH_REMATCH[2]}"

			# {} around variables
			if [[ ${match_again} =~ ^(.*)__(.+) ]]; then

				string_pre="${BASH_REMATCH[1]}"
				string_to_bold="${BASH_REMATCH[2]}"

				# {} around variables
				printf -v line "%s<strong>%s</strong>%s" "${string_pre}" "${string_to_bold}" "${string_post}"

			fi

		fi

		# If the line didn't change
		# use [[ ]] instead of [ ], add {} to variables
		[[ ${line} != "${orig}" ]] || break

	done

	#
	# Step: Check for unordered lists.
	#

	# Check exit code directly with e.g. 'if mycmd;', not indirectly with $?. [SC2181]
	# use -q instead of the redirect to null for stdout
	# add {} to line
	if echo "${line}" | grep -q '^\*' 2> /dev/null; then

		#
		# Step: Found an unordered list, start the HTML for it.
		#

		# Double quote to prevent globbing and word splitting. [SC2086]
		# use [[ ]] instead of [ ]
		# use a default value instead of pre-pending an X
		if [[ ${inside_a_list:-no} != yes ]]; then

			# {} around variables
			html="${html}<ul>"

			# quote right-hand side of variable assignments
			inside_a_list="yes"

		fi

		#
		# Step: Check for italic text.
		#

		# {} around variables
		while [[ ${line} == *_*?_* ]]; do

			# quote right-hand side of the variable assignment
			string_post="${line#*_}"
			string_filter="${string_post#*_}"

			# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
			# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
			# use [[ ]] instead of [ ]
			if [[ ${#string_filter} -lt ${#string_post} ]] && [[ ${#string_post} -lt ${#line} ]]; then

				# Expansions inside ${..} need to be quoted separately, otherwise they match as patterns. [SC2295]
				line="${line%%_"${string_post}"}<em>${string_post%%_"${string_filter}"}</em>${string_filter}"

			fi

		done

		#
		# Step: Add <li> & </li> around list entry.
		#

		# {} around variables
		html="${html}<li>${line#??}</li>"

	else

		# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck missed this one
		# use [[ ]] instead of [ ]
		# use a default value instead of pre-pending an X
		# use == instead of =
		if [[ ${inside_a_list:-no} == yes ]]; then

			# {} around variables
			html="${html}</ul>"

			# quote right-hand side of the variable assignment
			inside_a_list="no"

		fi

		# Use $(...) notation instead of legacy backticks `...`. [SC2006]
		# {} around variables
		# Get the heading level. (int >= 0)
		heading_level="$(expr "${line}" : "#\{1,\}")"

		# Double quote to prevent globbing and word splitting. [SC2086]
		# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
		# {} around variables
		# use [[ ]] instead of [ ]
		if [[ ${heading_level} -gt 0 ]] && [[ 7 -gt ${heading_level} ]]; then

			#
			# Step: Check for italic text.
			#

			# {} around variables
			while [[ ${line} == *_*?_* ]]; do

				# quote right-hand side of variable assignments
				string_post="${line#*_}"
				string_filter="${string_post#*_}"

				# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
				# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
				# use [[ ]] instead of [
				if [[ ${#string_filter} -lt ${#string_post} ]] && [[ ${#string_post} -lt ${#line} ]]; then

					# Expansions inside ${..} need to be quoted separately, otherwise they match as patterns. [SC2295]
					# {} around variables
					line="${line%%_"${string_post}"}<em>${string_post%%_"${string_filter}"}</em>${string_post}"

				fi

			done

			# quote right-hand side of the variable
			heading="${line:heading_level}"

			while [[ ${heading} == " "* ]]; do

				# quote right-hand side of the variable assignment
				heading="${heading# }"

			done

			#
			# Step: Add <h#> & </h#> around the heading entry.
			#

			# {} around variables
			html="${html}<h${heading_level}>${heading}</h${heading_level}>"

		else

			#
			# Step: Check for italic text.
			#

			# Use $(...) notation instead of legacy backticks `...`. [SC2006]
			# {} around variables
			# use -q instead of redirect of stdout
			grep -q '_..*_' <<< "${line}" && line="$(echo "${line}" | sed -E 's,_([^_]+)_,<em>\1</em>,g')"

			#
			# Step: Add paragraph elements around paragraphs.
			#

			# {} around variables
			html="${html}<p>${line}</p>"

		fi

	fi

done < "${1}"  # {} around variables

#
# Step: If we end while processing a list, close it.
#

# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
# use [[ ]] instead of [ ]
# use a default value instead of pre-pending an X
# use == instead of =
if [[ ${inside_a_list:-no} == yes ]]; then

	# {} around variables
	html="${html}</ul>"

fi

#
# Step: Output the rendered HTML.
#

# {} around variables
echo "${html}"
