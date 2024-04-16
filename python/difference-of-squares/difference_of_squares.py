"""Python Difference of Squares Exercism"""


def square_of_sum(number: int) -> int:
    """Calculates the square of sum.

    :param number: int
    :return: int
    """

    return (number * (number + 1) // 2) ** 2


def sum_of_squares(number: int) -> int:
    """Calculates the sum of squares.

    :param number: int
    :return: int
    """

    return (number * (number + 1) * (2 * number + 1)) // 6


def difference_of_squares(number: int) -> int:
    """Calculates the difference of squares.

    :param number: int
    :return: int
    """

    return square_of_sum(number) - sum_of_squares(number)
