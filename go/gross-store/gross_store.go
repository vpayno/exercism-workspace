package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	units := map[string]int{
		"quarter_of_a_dozen": 3,
		"half_of_a_dozen":    6,
		"dozen":              12,
		"small_gross":        120,
		"gross":              144,
		"great_gross":        1728,
	}

	return units
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	bill := map[string]int{}

	return bill
}

// inMap returns true if key is in map.
func inMap(dict map[string]int, key string) bool {
	_, found := dict[key]

	return found
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	var found bool = inMap(bill, item)
	var valid bool = inMap(units, unit)

	var result bool

	if valid {
		result = true

		if found {
			bill[item] += units[unit]
		} else {
			bill[item] = units[unit]
		}
	} else {
		result = false
	}

	return result
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	var result bool

	if inMap(bill, item) && inMap(units, unit) {
		result = true

		newQuantity := bill[item] - units[unit]

		if newQuantity < 0 {
			result = false
		} else if newQuantity > 0 {
			bill[item] -= units[unit]
		} else {
			delete(bill, item)
		}
	} else {
		result = false
	}

	return result
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	var result bool
	var quantity int

	if inMap(bill, item) {
		result = true
		quantity = bill[item]
	} else {
		result = false
	}

	return quantity, result
}
