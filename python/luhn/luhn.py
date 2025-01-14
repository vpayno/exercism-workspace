"""Python Luhn Exercism"""

import re
from itertools import chain


class String(str):
    """Extending String class/type"""

    def match(self, regex: str) -> bool:
        """Does the String match a regex?

        >>> s: String = String("1234 5678")
        >>> s
        '1234 5678'
        >>> s.match(r"^[0-9 ]+$")
        True
        >>> s.match(r"^[a-z ]+$")
        False

        :param regex: rstr
        :return: bool
        """

        return bool(re.match(regex, self))

    def extract_digits(self) -> list[int]:
        """Extracts digits from a code.

        >>> s: String = String("1234 5678")
        >>> s.extract_digits()
        [1, 2, 3, 4, 5, 6, 7, 8]

        :return: list[int]
        """

        def is_digit(rune: str) -> bool:
            """Test function for filter.

            >>> is_digit("a")
            False
            >>> is_digit("7")
            True

            :return: True if rune is a digit
            """

            return rune.isdigit()

        filtered = filter(is_digit, list(self))

        return [int(r) for r in filtered]


class Luhn:  # pylint: disable=too-few-public-methods
    """Determine if a number is a valid Luhn number."""

    def __init__(self, card_num: str) -> None:
        self.code: String = String(card_num.strip())

    def valid(self) -> bool:
        """Is this a valid Luhn number?

        >>> l: Luhn = Luhn("055 444 285")
        >>> l.valid()
        True
        >>> l: Luhn = Luhn("055 444 286")
        >>> l.valid()
        False
        >>> l: Luhn = Luhn("234 567 891 234")
        >>> l.valid()
        True
        >>> n: String = String("234 567 891 234")
        >>> n == "0"
        False
        >>> len(n) == 0
        False
        >>> n == "0"
        False
        >>> n.match(r"^([0-9 ])+$")
        True

        :return: bool
        """

        if (
            self.code == "0"
            or len(self.code) == 0
            or not self.code.match(r"^([0-9 ])+$")
        ):
            return False

        return self.__is_luhn_number()

    def __is_luhn_number(self) -> bool:
        """Is the code a valid luhn number?

        >>> l: Luhn = Luhn("055 444 285")
        >>> l._Luhn__is_luhn_number()
        True
        >>> l: Luhn = Luhn("055 444 286")
        >>> l._Luhn__is_luhn_number()
        False
        >>> digits: list[int] = l.code.extract_digits()
        >>> digits
        [0, 5, 5, 4, 4, 4, 2, 8, 6]
        >>> numbers: list[int] = l._Luhn__step_one_and_two(digits)
        >>> numbers
        [1, 5, 8, 4, 8, 2, 7, 6, 0]
        >>> digit_sum: int = sum(numbers)
        >>> digit_sum
        41
        >>> l: Luhn = Luhn("234 567 891 234")
        >>> l._Luhn__is_luhn_number()
        True
        >>> digits: list[int] = l.code.extract_digits()
        >>> digits
        [2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4]
        >>> numbers: list[int] = l._Luhn__step_one_and_two(digits)
        >>> numbers
        [4, 3, 8, 5, 3, 7, 7, 9, 2, 2, 6, 4]
        >>> digit_sum: int = sum(numbers)
        >>> digit_sum
        60

        :return: bool
        """

        digits: list[int] = self.code.extract_digits()

        numbers: list[int] = self.__step_one_and_two(digits)

        digit_sum: int = sum(numbers)

        return (digit_sum % 10) == 0

    def __step_one_and_two(self, digits: list[int]) -> list[int]:
        """Performs steps one and two of the luhn number verification algorithm.

        >>> l: Luhn = Luhn("0123456789")
        >>> d: list[int] = l.code.extract_digits()
        >>> d
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        >>> l._Luhn__step_one_and_two(d)
        [0, 1, 4, 3, 8, 5, 3, 7, 7, 9]
        >>> l: Luhn = Luhn("59")
        >>> d: list[int] = l.code.extract_digits()
        >>> d
        [5, 9]
        >>> s = l._Luhn__step_one_and_two(d)
        >>> s
        [1, 9]
        >>> sum(s)
        10
        >>> l: Luhn = Luhn(" 0")
        >>> d: list[int] = l.code.extract_digits()
        >>> d
        [0]
        >>> l._Luhn__step_one_and_two(d)
        [0]
        >>> sum(l._Luhn__step_one_and_two(d))
        0
        >>> l: Luhn = Luhn("234 567 891 234")
        >>> d: list[int] = l.code.extract_digits()
        >>> d
        [2, 3, 4, 5, 6, 7, 8, 9, 1, 2, 3, 4]
        >>> l._Luhn__step_one_and_two(d)
        [4, 3, 8, 5, 3, 7, 7, 9, 2, 2, 6, 4]
        >>> sum(l._Luhn__step_one_and_two(d))
        57

        :return: list[int]
        """

        digits.reverse()

        even: list[int] = digits[0::2]
        odd: list[int] = digits[1::2]

        new_odd: list[int] = []

        for n in odd:
            n *= 2

            if n > 9:
                n -= 9

            new_odd.append(n)

        # flatten the list of tuples
        new_list: list[int] = list(chain.from_iterable(zip(even, new_odd)))

        new_list.reverse()

        if len(even) != len(odd):
            new_list.append(even[-1])

        return new_list
