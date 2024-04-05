"""Functions to automate Conda airlines ticketing system."""

from typing import Any, Generator

type index_t = int  # type: ignore[valid-type]
type quantity_t = int  # type: ignore[valid-type]

type letter_t = str  # type: ignore[valid-type]
type letters_t = list[letter_t]  # type: ignore[valid-type]

type row_t = int  # type: ignore[valid-type]
type seat_t = str  # type: ignore[valid-type]
type seats_t = list[seat_t]  # type: ignore[valid-type]

type name_t = str  # type: ignore[valid-type]
type passengers_t = list[name_t]  # type: ignore[valid-type]
type seat_assignments_t = dict[name_t, seat_t]  # type: ignore[valid-type]

type code_t = str  # type: ignore[valid-type]
type flight_id_t = str  # type: ignore[valid-type]


def generate_seat_letters(quantity: quantity_t) -> Generator[letter_t, Any, Any]:
    """Generate a series of letters for airline seats.

    :param quantity: int - total number of seat letters to be generated.
    :return: generator - generator that yields seat letters.

    Seat letters are generated from A to D.
    After D it should start again with A.

    Example: A, B, C, D
    """

    letters: letters_t = ["A", "B", "C", "D"]

    for pos in range(0, quantity):
        index: index_t = pos % len(letters)

        yield letters[index]


def generate_seats(quantity: quantity_t) -> Generator[seat_t, Any, Any]:
    """Generate a series of identifiers for airline seats.

    :param quantity: int - total number of seats to be generated.
    :return: generator - generator that yields seat numbers.

    A seat number consists of the row number and the seat letter.

    There is no row 13.
    Each row has 4 seats.

    Seats should be sorted from low to high.

    Example: 3C, 3D, 4A, 4B
    """

    letter: Generator[letter_t, Any, Any] = generate_seat_letters(quantity)
    row: row_t = 0

    for _ in range(1, quantity + 1):
        seat: seat_t = next(letter)

        if seat == "A":
            row += 1

        if row == 13:
            row += 1

        yield f"{row}{seat}"


def assign_seats(passengers: passengers_t) -> seat_assignments_t:
    """Assign seats to passengers.

    :param passengers: list[str] - a list of strings containing names of passengers.
    :return: dict - with the names of the passengers as keys and seat numbers as values.

    Example output: {"Adele": "1A", "Björk": "1B"}
    """

    seat_assignments: seat_assignments_t = {}
    seat: Generator[seat_t, Any, Any] = generate_seats(len(passengers))

    for passenger in passengers:
        seat_assignments[passenger] = next(seat)

    return seat_assignments


def generate_codes(
    seat_numbers: seats_t, flight_id: flight_id_t
) -> Generator[code_t, Any, Any]:
    """Generate codes for a ticket.

    :param seat_numbers: list[str] - list of seat numbers.
    :param flight_id: str - string containing the flight identifier.
    :return: generator - generator that yields 12 character long ticket codes.
    """

    for seat in seat_numbers:
        code: code_t = f"{seat}{flight_id}"

        yield f"{code:012}"
