"""Python Pangram Exercism"""


def is_pangram(text: str) -> bool:
    """Is the input a pangram?

    >>> text: set[str] = " ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz"
    >>> len(sorted({r for r in text.lower() if r.isalpha()}))
    26

    :param text: string
    :return: bool
    """

    if not text or len(text) < 26:
        return False

    letters: set[str] = {r for r in text.lower() if r.isalpha()}

    return len(letters) == 26
