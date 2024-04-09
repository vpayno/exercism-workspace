"""Raindrops exercism: https://exercism.org/tracks/python/exercises/raindrops"""


def convert(number: int) -> str:
    """Converts a number to the sound of rain drops.

    :param number: positive integer
    :return: string with rain sounds or the number if it can't be converted
    """

    sounds: list[str] = []

    if number % 3 == 0:
        sounds.append("Pling")

    if number % 5 == 0:
        sounds.append("Plang")

    if number % 7 == 0:
        sounds.append("Plong")

    if len(sounds) == 0:
        sounds.append(f"{number}")

    return "".join(sounds)
