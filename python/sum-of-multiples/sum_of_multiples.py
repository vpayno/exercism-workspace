"""Sum of Multiples Python Exercism"""

from typing import List, Set


def sum_of_multiples(limit: int, divisors: List[int]) -> int:
    """Sum the unique multiples of a number

    :param limit: int
    :param divisors: Set[int]
    :return int
    """
    result: int = 0
    multiples: Set[int] = set()

    # remove duplicate numbers and zeros from divisors list
    divisors = [n for n in set(divisors) if n != 0]
    # print(f"divisors={divisors}")

    for j in divisors:
        for i in range(limit):
            # print(f"{i} % {j} = {i%j}")
            if i % j == 0:
                multiples.add(i)

    # print(f"multiples={multiples}")
    result = sum(multiples)

    return result
