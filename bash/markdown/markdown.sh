#!/usr/bin/env bash

# 1. Clean up whitespace.
# 2. Address all shellcheck (v0.8.0) issues.
# 3. Style clean up.
# 4. Add types.

declare orig
declare line
declare post
declare pre
declare inside_a_list
declare h
declare one
declare two
declare -i n
declare -i s
declare -i t
declare HEAD

while IFS= read -r line; do

	while true; do

		# {} braces and double quotes
		orig="${line}"

		# {} around variables
		if [[ ${line} =~ ^(.+)__(.*) ]]; then

			# double quotes, breakup line
			post="${BASH_REMATCH[2]}"
			pre="${BASH_REMATCH[1]}"

			# {} around variables
			if [[ ${pre} =~ ^(.*)__(.+) ]]; then

				# {} around variables
				printf -v line "%s<strong>%s</strong>%s" "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${post}"

			fi

		fi

		# use [[ ]] instead of [ ], add {} to variables
		[[ ${line} != "${orig}" ]] || break

	done

	# Check exit code directly with e.g. 'if mycmd;', not indirectly with $?. [SC2181]
	# use -q instead of the redirect to null for stdout
	# add {} to line
	if echo "${line}" | grep -q '^\*' 2> /dev/null; then


		# Double quote to prevent globbing and word splitting. [SC2086]
		# use [[ ]] instead of [ ]
		# use a default value instead of pre-pending an X
		if [[ ${inside_a_list:-no} != yes ]]; then

			# {} around variables
			h="${h}<ul>"

			# quote right-hand side of variable assignments
			inside_a_list="yes"

		fi

		# {} around variables
		while [[ ${line} == *_*?_* ]]; do

			# quote right-hand side of the variable assignment
			one="${line#*_}"
			two="${one#*_}"

			# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
			# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
			# use [[ ]] instead of [ ]
			if [[ ${#two} -lt ${#one} ]] && [[ ${#one} -lt ${#line} ]]; then

				# Expansions inside ${..} need to be quoted separately, otherwise they match as patterns. [SC2295]
				line="${line%%_"${one}"}<em>${one%%_"${two}"}</em>${two}"

			fi

		done

		# {} around variables
		h="${h}<li>${line#??}</li>"

	else

		# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck missed this one
		# use [[ ]] instead of [ ]
		# use a default value instead of pre-pending an X
		# use == instead of =
		if [[ ${inside_a_list:-no} == yes ]]; then

			# {} around variables
			h="${h}</ul>"

			# quote right-hand side of the variable assignment
			inside_a_list="no"

		fi

		# Use $(...) notation instead of legacy backticks `...`. [SC2006]
		# {} around variables
		n="$(expr "${line}" : "#\{1,\}")"

		# Double quote to prevent globbing and word splitting. [SC2086]
		# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
		# {} around variables
		# use [[ ]] instead of [ ]
		if [[ ${n} -gt 0 ]] && [[ 7 -gt ${n} ]]; then

			# {} around variables
			while [[ ${line} == *_*?_* ]]; do

				# quote right-hand side of variable assignments
				s="${line#*_}"
				t="${s#*_}"

				# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
				# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
				# use [[ ]] instead of [
				if [[ ${#t} -lt ${#s} ]] && [[ ${#s} -lt ${#line} ]]; then

					# Expansions inside ${..} need to be quoted separately, otherwise they match as patterns. [SC2295]
					# {} around variables
					line="${line%%_"${s}"}<em>${s%%_"${t}"}</em>${t}"

				fi

			done

			# quote right-hand side of the variable
			HEAD="${line:n}"

			while [[ ${HEAD} == " "* ]]; do

				# quote right-hand side of the variable assignment
				HEAD="${HEAD# }"

			done

			# {} around variables
			h="${h}<h${n}>${HEAD}</h${n}>"

		else

			# Use $(...) notation instead of legacy backticks `...`. [SC2006]
			# {} around variables
			# use -q instead of redirect of stdout
			grep -q '_..*_' <<< "${line}" && line="$(echo "${line}" | sed -E 's,_([^_]+)_,<em>\1</em>,g')"

			# {} around variables
			h="${h}<p>${line}</p>"

		fi

	fi

done < "${1}"  # {} around variables

# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
# use [[ ]] instead of [ ]
# use a default value instead of pre-pending an X
# use == instead of =
if [[ ${inside_a_list:-no} == yes ]]; then

	# {} around variables
	h="${h}</ul>"

fi

# {} around variables
echo "${h}"
