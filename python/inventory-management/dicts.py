"""Functions to keep track and alter inventory."""

from collections import defaultdict
from typing import Dict, List, Tuple


def create_inventory(items: List[str]) -> Dict[str, int]:
    """Create a dict that tracks the amount (count) of each element on the `items` list.

    :param items: list - list of items to create an inventory from.
    :return: dict - the inventory dictionary.
    """
    return {name: items.count(name) for name in set(items)}


def add_items(inventory: Dict[str, int], items: List[str]) -> Dict[str, int]:
    """Add or increment items in inventory using elements from the items `list`.

    :param inventory: dict - dictionary of existing inventory.
    :param items: list - list of items to update the inventory with.
    :return: dict - the inventory updated with the new items.
    """
    # defaultdict assumes a value of int:0 when the key doesn't exist
    new_inventory: Dict[str, int] = defaultdict(int)

    new_inventory.update(create_inventory(items))

    item: str
    count: int
    for item in inventory:
        count = inventory[item]
        new_inventory[item] += count

    # defaultdict to dict
    return new_inventory.copy()


def decrement_items(inventory: Dict[str, int], items: List[str]) -> Dict[str, int]:
    """Decrement items in inventory using elements from the `items` list.

    :param inventory: dict - inventory dictionary.
    :param items: list - list of items to decrement from the inventory.
    :return: dict - updated inventory with items decremented.
    """
    return {name: max(inventory[name] - items.count(name), 0) for name in set(items)}


def remove_item(inventory: Dict[str, int], item: str) -> Dict[str, int]:
    """Remove item from inventory if it matches `item` string.

    :param inventory: dict - inventory dictionary.
    :param item: str - item to remove from the inventory.
    :return: dict - updated inventory with item removed. Current inventory if item does not match.
    """
    new_inventory: Dict[str, int] = inventory.copy()

    # use _ to show you don't intend to use the return value
    # pop() without a default value will through a KeyError exception when the key doesn't exist
    _ = new_inventory.pop(item, None)

    return new_inventory


def list_inventory(inventory: Dict[str, int]) -> List[Tuple[str, int]]:
    """Create a list containing all (item_name, item_count) pairs in inventory.

    :param inventory: dict - an inventory dictionary.
    :return: list of tuples - list of key, value pairs from the inventory dictionary.
    """
    return [(name, count) for name, count in inventory.items() if count > 0]
