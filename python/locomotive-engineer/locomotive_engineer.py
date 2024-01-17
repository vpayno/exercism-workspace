"""Functions which helps the locomotive engineer to keep track of the train."""

from typing import Dict, List, Tuple


def get_list_of_wagons(*args: str) -> List[str]:
    """Return a list of wagons.

    :param: arbitrary number of wagons.
    :return: list - list of wagons.
    """
    return list(args)


def fix_list_of_wagons(each_wagons_id: List[int], missing_wagons: List[int]) -> List[int]:
    """Fix the list of wagons.

    :parm each_wagons_id: list - the list of wagons.
    :parm missing_wagons: list - the list of missing wagons.
    :return: list - list of wagons.
    """
    return [each_wagons_id[2]] + missing_wagons + each_wagons_id[3:] + each_wagons_id[0:2]


def add_missing_stops(route: Dict[str, str | List[str]], **kwargs: str) -> Dict[str, str | List[str]]:
    """Add missing stops to route dict.

    :param route: dict - the dict of routing information.
    :param: arbitrary number of stops.
    :return: dict - updated route dictionary.
    """
    new_route: Dict[str, str | List[str]] = route.copy()

    new_route["stops"] = list(kwargs.values())

    return new_route


def extend_route_information(route: Dict[str, str], more_route_information: Dict[str, str]) -> Dict[str, str]:
    """Extend route information with more_route_information.

    :param route: dict - the route information.
    :param more_route_information: dict -  extra route information.
    :return: dict - extended route information.
    """
    new_route: Dict[str, str] = route.copy()

    new_route.update(more_route_information)

    return new_route


def fix_wagon_depot(wagons_rows: List[List[Tuple[int, str]]]) -> List[List[Tuple[int, str]]]:
    """Fix the list of rows of wagons.

    :param wagons_rows: list[list[tuple]] - the list of rows of wagons.
    :return: list[list[tuple]] - list of rows of wagons.
    """
    new_wagons_row: List[List[Tuple[int, str]]] = []
    wagon_row: List[Tuple[int, str]]

    col: int
    for col in range(3):
        wagon_row = [row[col] for row in wagons_rows]
        new_wagons_row.append(wagon_row)

    return new_wagons_row
