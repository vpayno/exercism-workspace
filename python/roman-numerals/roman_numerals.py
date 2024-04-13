"""Python Roman Numerals Exercism"""

from collections import OrderedDict

type modern_numeral_t = int  # type: ignore[valid-type]
type roman_numeral_t = str  # type: ignore[valid-type]
type map_d2r_t = OrderedDict[modern_numeral_t, roman_numeral_t]  # type: ignore[valid-type]


def roman(number: modern_numeral_t) -> roman_numeral_t:
    rn: roman_numeral_t = ""

    d2r: map_d2r_t = OrderedDict()
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
