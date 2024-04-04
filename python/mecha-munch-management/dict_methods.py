"""Functions to manage a users shopping cart items."""

# runners are still using py 3.11, can't use 3.12 type definitions
name_t = str
quantity_t = int
cart_t = dict[name_t, quantity_t]
items_t = list[name_t] | tuple[name_t]
recipes_t = dict[name_t, cart_t]
update_t = tuple[name_t, cart_t]
updates_t = list[update_t] | tuple[update_t]
refrigirate_t = bool
aisle_t = list[name_t | refrigirate_t]
aisle_map_t = dict[name_t, aisle_t]
inventory_entry_t = list[quantity_t | name_t | refrigirate_t]
fufillment_t = dict[name_t, inventory_entry_t]
message_t = str


def add_item(current_cart: cart_t, items_to_add: items_t) -> cart_t:
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """

    for item in items_to_add:
        _: int = current_cart.setdefault(item, 0)
        current_cart[item] += 1

    return current_cart


def read_notes(notes: items_t) -> cart_t:
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """

    cart: cart_t = {}

    return add_item(cart, notes)


def update_recipes(ideas: recipes_t, recipe_updates: updates_t) -> recipes_t:
    """Update the recipe ideas dictionary. Replaces the existing list of items with a new list, don't update/merge.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: dict - dictionary with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """

    update: update_t

    for update in recipe_updates:
        recipe_name: name_t = update[0]
        items: cart_t = update[1]

        _ = ideas.setdefault(recipe_name, {})

        ideas[recipe_name] = items

    return ideas


def sort_entries(cart: cart_t) -> cart_t:
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """

    return dict(sorted(cart.items()))


def send_to_store(cart: cart_t, aisle_mapping) -> fufillment_t:
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """

    fufillment: fufillment_t = {}

    item_name: name_t
    item_quantity: quantity_t
    aisle: aisle_t

    for item_name, item_quantity in cart.items():
        aisle = aisle_mapping.setdefault(item_name, ["Aisle 0", False])
        fufillment[item_name] = [item_quantity, aisle[0], aisle[1]]

    return dict(sorted(fufillment.items(), reverse=True))


def update_store_inventory(
    fulfillment_cart: fufillment_t, store_inventory: fufillment_t
) -> fufillment_t:
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """

    new_inventory: fufillment_t = store_inventory.copy()

    item_name: name_t
    order_quantity: quantity_t
    inventory_quantity: quantity_t
    new_quantity: quantity_t | message_t
    data: inventory_entry_t

    for item_name in fulfillment_cart:
        order_quantity = int(
            fulfillment_cart.setdefault(item_name, [0, "Aisle 0", False])[0]
        )
        inventory_quantity = int(
            store_inventory.setdefault(item_name, [0, "Aisle 0", False])[0]
        )
        new_quantity = inventory_quantity - order_quantity
        new_quantity = "Out of Stock" if new_quantity <= 0 else new_quantity
        data = store_inventory.setdefault(item_name, [0, "Aisle 0", False])
        data[0] = new_quantity

        new_inventory[item_name] = data

    return new_inventory
