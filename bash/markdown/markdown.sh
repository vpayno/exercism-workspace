#!/usr/bin/env bash

# 1. Clean up whitespace.
# 2. Address all shellcheck (v0.8.0) issues.

while IFS= read -r line; do

	while true; do

		orig=$line

		if [[ $line =~ ^(.+)__(.*) ]]; then

			post=${BASH_REMATCH[2]};pre=${BASH_REMATCH[1]}

			if [[ $pre =~ ^(.*)__(.+) ]]; then

				printf -v line "%s<strong>%s</strong>%s" "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "$post"

			fi

		fi

		[ "$line" != "$orig" ] || break

	done

	# Check exit code directly with e.g. 'if mycmd;', not indirectly with $?. [SC2181]
	if echo "$line" | grep '^\*' > /dev/null 2>&1; then


		# Double quote to prevent globbing and word splitting. [SC2086]
		if [ "X$inside_a_list" != Xyes ]; then

			h="$h<ul>"
			inside_a_list=yes

		fi

		while [[ $line == *_*?_* ]]; do

			one=${line#*_}
			two=${one#*_}

			# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
			# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
			if [ "${#two}" -lt "${#one}" ] && [ "${#one}" -lt "${#line}" ]; then

				# Expansions inside ${..} need to be quoted separately, otherwise they match as patterns. [SC2295]
				line="${line%%_"$one"}<em>${one%%_"$two"}</em>$two"

			fi

		done

		h="$h<li>${line#??}</li>"

	else

		# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck missed this one
		if [ "X$inside_a_list" = Xyes ]; then

			h="$h</ul>"
			inside_a_list=no

		fi

		# Use $(...) notation instead of legacy backticks `...`. [SC2006]
		n="$(expr "$line" : "#\{1,\}")"

		# Double quote to prevent globbing and word splitting. [SC2086]
		# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
		if [ "$n" -gt 0 ] && [ 7 -gt "$n" ]; then

			while [[ $line == *_*?_* ]]; do

				s=${line#*_}
				t=${s#*_}

				# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
				# Prefer [ p ] && [ q ] as [ p -a q ] is not well defined. [SC2166]
				if [ "${#t}" -lt "${#s}" ] && [ "${#s}" -lt "${#line}" ]; then

					# Expansions inside ${..} need to be quoted separately, otherwise they match as patterns. [SC2295]
					line="${line%%_"$s"}<em>${s%%_"$t"}</em>$t"

				fi

			done

			HEAD=${line:n}

			while [[ $HEAD == " "* ]]; do

				HEAD=${HEAD# }

			done

			h="$h<h$n>$HEAD</h$n>"

		else

			# Use $(...) notation instead of legacy backticks `...`. [SC2006]
			grep '_..*_' <<<"$line" > /dev/null && line="$(echo "$line" | sed -E 's,_([^_]+)_,<em>\1</em>,g')"

			h="$h<p>$line</p>"

		fi

	fi

done < "$1"

# Double quote to prevent globbing and word splitting. [SC2086] - shellcheck misssed this one
if [ "X$inside_a_list" = Xyes ]; then

	h="$h</ul>"

fi

echo "$h"
