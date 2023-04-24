"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""


# how long the lasagna should take to bake
EXPECTED_BAKE_TIME: int = 40

# the amount of time each layer needs to bake
PREPARATION_TIME: int = 2


def bake_time_remaining(elapsed_bake_time: int) -> int:
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """
    return EXPECTED_BAKE_TIME - elapsed_bake_time


def preparation_time_in_minutes(number_of_layers: int) -> int:
    """Calculate preparation time.

    :param number_of_layers: int - number of layers in the lasagna
    :return: int - preparation time for the lasagna

    Takes the number of layers you want to add to the lasagna as an argument and
    returns how many minutes they take to bake.
    """
    return PREPARATION_TIME * number_of_layers


def elapsed_time_in_minutes(number_of_layers: int, actual_minutes_in_oven: int) -> int:
    """Calculate elapsed preparing and baking time.

    :param number_of_layers: int - number of layers in the lasagna
    :param actual_minutes_in_oven_bake_time: int - time already in the oven
    :return: int - elapsed cooking time

    Returns `actual_minutes_in_oven` added to `preparation_time_in_minutes()`.
    """
    return preparation_time_in_minutes(number_of_layers) + actual_minutes_in_oven
