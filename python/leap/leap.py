"""
Leap Year exercise
https://exercism.org/tracks/python/exercises/leap
"""


def leap_year(year):
    """Checks to see if given year is a leap year."""

    if year % 400 == 0:
        return True

    if year % 100 == 0:
        return False

    if year % 4 == 0:
        return True

    return False
