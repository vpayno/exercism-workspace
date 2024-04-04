"""Functions to manage a users shopping cart items."""

# runners are still using py 3.11, can't use 3.12 type definitions
NameT = str
QuantityT = int
CartT = dict[NameT, QuantityT]
ItemsT = list[NameT] | tuple[NameT]
RecipesT = dict[NameT, CartT]
UpdateT = tuple[NameT, CartT]
UpdatesT = list[UpdateT] | tuple[UpdateT]
RefrigirateT = bool
AisleT = list[NameT | RefrigirateT]
AisleMapT = dict[NameT, AisleT]
InventoryEntryT = list[QuantityT | NameT | RefrigirateT]
FufillmentT = dict[NameT, InventoryEntryT]
MessageT = str


def add_item(current_cart: CartT, items_to_add: ItemsT) -> CartT:
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """

    for item in items_to_add:
        _: int = current_cart.setdefault(item, 0)
        current_cart[item] += 1

    return current_cart


def read_notes(notes: ItemsT) -> CartT:
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """

    cart: CartT = {}

    return add_item(cart, notes)


def update_recipes(ideas: RecipesT, recipe_updates: UpdatesT) -> RecipesT:
    """Update the recipe ideas dictionary. Replaces the existing list of items with a new list, don't update/merge.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: dict - dictionary with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """

    update: UpdateT

    for update in recipe_updates:
        recipe_name: NameT = update[0]
        items: CartT = update[1]

        _ = ideas.setdefault(recipe_name, {})

        ideas[recipe_name] = items

    return ideas


def sort_entries(cart: CartT) -> CartT:
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """

    return dict(sorted(cart.items()))


def send_to_store(cart: CartT, aisle_mapping) -> FufillmentT:
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """

    fufillment: FufillmentT = {}

    item_name: NameT
    item_quantity: QuantityT
    aisle: AisleT

    for item_name, item_quantity in cart.items():
        aisle = aisle_mapping.setdefault(item_name, ["Aisle 0", False])
        fufillment[item_name] = [item_quantity, aisle[0], aisle[1]]

    return dict(sorted(fufillment.items(), reverse=True))


def update_store_inventory(
    fulfillment_cart: FufillmentT, store_inventory: FufillmentT
) -> FufillmentT:
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """

    new_inventory: FufillmentT = store_inventory.copy()

    item_name: NameT
    order_quantity: QuantityT
    inventory_quantity: QuantityT
    new_quantity: QuantityT | MessageT
    data: InventoryEntryT

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
