"""Python Roman Numerals Exercism"""

from collections import OrderedDict

ModernNumeralT = int
RomanNumeralT = str
MapD2RT = OrderedDict[ModernNumeralT, RomanNumeralT]


def roman(number: ModernNumeralT) -> RomanNumeralT:
    """Convert a decimal number to a roman numeral.

    :param number: integer
    :return: string
    """

    rn: RomanNumeralT = ""

    d2r: MapD2RT = OrderedDict()
    d2r[1] = "I"
    d2r[4] = "IV"
    d2r[5] = "V"
    d2r[9] = "IX"
    d2r[10] = "X"
    d2r[40] = "XL"
    d2r[50] = "L"
    d2r[90] = "XC"
    d2r[100] = "C"
    d2r[400] = "CD"
    d2r[500] = "D"
    d2r[900] = "CM"
    d2r[1000] = "M"

    for d, r in reversed(d2r.items()):
        while number >= d:
            rn = f"{rn}{r}"
            number -= d

    return rn
