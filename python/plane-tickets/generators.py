"""Functions to automate Conda airlines ticketing system."""

from typing import Any, Generator

IndexT = int
QuantityT = int

LetterT = str
LettersT = list[LetterT]

RowT = int
SeatT = str
SeatsT = list[SeatT]

NameT = str
PassengersT = list[NameT]
SeatAssignmentsT = dict[NameT, SeatT]

CodeT = str
FlightIdT = str


def generate_seat_letters(quantity: QuantityT) -> Generator[LetterT, Any, Any]:
    """Generate a series of letters for airline seats.

    :param quantity: int - total number of seat letters to be generated.
    :return: generator - generator that yields seat letters.

    Seat letters are generated from A to D.
    After D it should start again with A.

    Example: A, B, C, D
    """

    letters: LettersT = ["A", "B", "C", "D"]

    for pos in range(0, quantity):
        index: IndexT = pos % len(letters)

        yield letters[index]


def generate_seats(quantity: QuantityT) -> Generator[SeatT, Any, Any]:
    """Generate a series of identifiers for airline seats.

    :param quantity: int - total number of seats to be generated.
    :return: generator - generator that yields seat numbers.

    A seat number consists of the row number and the seat letter.

    There is no row 13.
    Each row has 4 seats.

    Seats should be sorted from low to high.

    Example: 3C, 3D, 4A, 4B
    """

    letter: Generator[LetterT, Any, Any] = generate_seat_letters(quantity)
    row: RowT = 0

    for _ in range(1, quantity + 1):
        seat: SeatT = next(letter)

        if seat == "A":
            row += 1

        if row == 13:
            row += 1

        yield f"{row}{seat}"


def assign_seats(passengers: PassengersT) -> SeatAssignmentsT:
    """Assign seats to passengers.

    :param passengers: list[str] - a list of strings containing names of passengers.
    :return: dict - with the names of the passengers as keys and seat numbers as values.

    Example output: {"Adele": "1A", "Björk": "1B"}
    """

    seat_assignments: SeatAssignmentsT = {}
    seat: Generator[SeatT, Any, Any] = generate_seats(len(passengers))

    for passenger in passengers:
        seat_assignments[passenger] = next(seat)

    return seat_assignments


def generate_codes(
    seat_numbers: SeatsT, flight_id: FlightIdT
) -> Generator[CodeT, Any, Any]:
    """Generate codes for a ticket.

    :param seat_numbers: list[str] - list of seat numbers.
    :param flight_id: str - string containing the flight identifier.
    :return: generator - generator that yields 12 character long ticket codes.
    """

    for seat in seat_numbers:
        code: CodeT = f"{seat}{flight_id}"

        yield f"{code:012}"
