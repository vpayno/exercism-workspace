"""Reverse string Exercism in Python"""


def reverse(text: str) -> str:
    """Reverses the order of the runes in the passed string.

    :param text: utf-8 string
    :return: reversed order utf-8 string
    """

    return "".join(reversed(text))
