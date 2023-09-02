#!/usr/bin/gawk --lint --file

@load "ordchr"

# These variables are initialized on the command line (using '-v'):
# -direction -> ^(encode|decode)$

function shift_letter(original) {
    if (match(original, /^[0-9]$/)) {
        return original
    }

    offset = 26 - 1

    shifted = chr(offset - (ord(original) - ord("a")) + ord("a"))

    return shifted
}

function atbash_cipher(input) {
    cipher_text = ""

    if (length(input) == 0) {
        return cipher_text
    }

    filtered = input
    _ = gsub(/[^a-zA-Z0-9]/, "", filtered)

    letter_count = split(filtered, letters, "")

    if (letter_count == 0) {
        # treating this as a different issue from just getting an empty string
        return "error: plain-text can't be empty"
    }

    for (i = 1; i <= length(filtered); i++) {
        letter = tolower(letters[i])
        #print "plain   letter: [" letter "]"
        shifted_letter = shift_letter(letter)
        #print "shifted letter: [" shifted_letter "]"

        if (length(cipher_text) == 0) {
            cipher_text = shifted_letter
        } else {
            cipher_text = cipher_text shifted_letter
        }

        if (direction == "encode") {
            cipher_text = gensub(/[a-z0-9]{5}\B/, "& ", "g", cipher_text)
        }
    }

    return cipher_text
}

BEGIN {
}

{
    # let's make sure direction isn't being used to inject code
    if (! match(direction, /^(encode|decode)$/)) {
        print "error: invalid command [" direction "], only supported commands are ^(encode|decode)$"
        exit 1
    }

    print atbash_cipher($0)
}

END {
}
