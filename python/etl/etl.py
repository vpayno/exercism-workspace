"""ETL Python Exercism"""

from typing import Dict, List


def transform(legacy_data: Dict[int, List[str]]) -> Dict[str, int]:
    """Transforms old scrabble scores into new scrabble scores.

    param: legacy_data: Dict[int, List[str]] - {1: ["A", "E"], 2: ["D", "G"]}
    return: new_data: Dict[str, int] - {"a": 1, "d": 2, "e": 1, "g": 2}
    """
    new_data: Dict[str, int] = {}
    letters: List[str]
    letter: str
    score: int

    for score, letters in legacy_data.items():
        for letter in letters:
            letter = letter.lower()
            new_data[letter] = score

    return new_data
