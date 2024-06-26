"""Python Scrabble Score Exercism"""


def score_letter(letter: str) -> int:
    """Scores an individual scrabble letter.

    :param letter: lowercase character
    :result: numeric score
    """

    result: int = 0

    match letter:
        case "a" | "e" | "i" | "o" | "u" | "l" | "n" | "r" | "s" | "t":
            result = 1
        case "d" | "g":
            result = 2
        case "b" | "c" | "m" | "p":
            result = 3
        case "f" | "h" | "v" | "w" | "y":
            result = 4
        case "k":
            result = 5
        case "j" | "x":
            result = 8
        case "q" | "z":
            result = 10
        case _:
            result = 0

    return result


def score(word: str) -> int:
    """Generate the score of a scrabble word.

    :param word: string of letters
    :return: numerical score
    """

    result: int = 0
    chars: list[str] = [*word.lower()]

    result = sum(map(score_letter, chars))

    return result
