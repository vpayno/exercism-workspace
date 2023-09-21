pub fn reply(remark: &str) -> &str {
    println!("Remark: {}", remark);

    match remark {
        // This is how he responds to silence. The convention used for silence is nothing, or various combinations of whitespace characters.
        remark if is_silence(remark) => {
            println!("Response to silence:");
            "Fine. Be that way!"
        }

        // This is what he says if you yell a question at him.
        remark if is_yelling(remark) && is_question(remark) => {
            println!("Response to a yelling question:");
            "Calm down, I know what I'm doing!"
        }

        // This is his answer if you YELL AT HIM. The convention used for yelling is ALL CAPITAL LETTERS.
        remark if is_yelling(remark) && !is_question(remark) => {
            println!("Response to a yelling statement:");
            "Whoa, chill out!"
        }

        // This is his response if you ask him a question, such as "How are you?" The convention used for questions is that it ends with a question mark.
        remark if !is_yelling(remark) && is_question(remark) => {
            println!("Response to a yelling question:");
            "Sure."
        }

        // This is what he answers to anything else.
        _ => "Whatever.",
    }
}

// yelling has to have letters that are all in caps and possibly other characters
fn is_yelling(remark: &str) -> bool {
    match remark.trim() {
        // not yelling if there aren't any lettters in the string
        remark if remark.chars().filter(|c| c.is_alphabetic()).count() == 0 => {
            println!("is_yelling(): false - found string without letters");
            false
        }

        // not yelling if there's at least 1 lowercase letter in the string
        remark if remark.chars().any(|c| c.is_ascii_lowercase()) => {
            println!("is_yelling(): false - found lower case");
            false
        }

        // are all the letters in the string uppercase letters?
        remark
            if remark
                .chars()
                .filter(|c| c.is_alphabetic())
                .all(|c| c.is_ascii_uppercase()) =>
        {
            println!("is_yelling(): true - found alpha upcase onlyletters");
            true
        }

        // catch-all, not yelling
        _ => {
            println!("is_yelling(): false - everything else");
            false
        }
    }
}

// only requirement is that it ends in a question mark
fn is_question(remark: &str) -> bool {
    remark.trim().ends_with('?')
}

// only whitespace or empty string
fn is_silence(remark: &str) -> bool {
    remark.trim().is_empty()
}
