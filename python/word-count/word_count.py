"""Word Count Python Exercism"""


import re
from collections import defaultdict
from typing import Dict


def count_words(sentence: str) -> Dict[str, int]:
    """Counts the number of times each word in a string is used.

    :param sentence: str - string we're going to count
    :return: Dict[str, int] - current round and the two that follow.
    """
    counts: Dict[str, int] = defaultdict(int)

    # remove surrounding quotes
    sentence = sentence.strip("'")

    # replace tabs with spaces
    sentence = sentence.expandtabs(tabsize=1)

    # replace punctuation and funny characters with spaces
    sentence = re.sub(r"[,.;:_!&@$%^&]", " ", sentence)

    for line in sentence.splitlines():
        for word in line.split(" "):
            # skip empty words
            if not word:
                continue

            # lower case the dict key
            word = word.lower()

            # remove surrounding quotes
            word = word.strip("'")

            # increment the word count in the dictionary
            counts[word] += 1

    return counts
