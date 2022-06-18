package cards

// FavoriteCards returns a slice with the cards 2, 6 and 9 in that order.
func FavoriteCards() []int {
	return []int{2, 6, 9}
}

// GetItem retrieves an item from a slice at given position.
// If the index is out of range, we want it to return -1.
func GetItem(slice []int, index int) int {
	var result int

	if index >= 0 && index < len(slice) {
		result = slice[index]
	} else {
		result = -1
	}

	return result
}

// SetItem writes an item to a slice at given position overwriting an existing value.
// If the index is out of range the value needs to be appended.
func SetItem(slice []int, index, value int) []int {
	if index >= 0 && index < len(slice) {
		slice[index] = value
	} else {
		slice = append(slice, value)
	}

	return slice
}

// PrependItems adds an arbitrary number of values at the front of a slice.
func PrependItems(slice []int, value ...int) []int {
	var newSlice []int = []int{}
	newSlice = append(newSlice, slice...)

	if value != nil {
		newSlice = append(value, slice...)
	}

	return newSlice
}

// RemoveItem removes an item from a slice by modifying the existing slice.
func RemoveItem(slice []int, index int) []int {
	var newSlice []int = []int{}

	if index >= 0 && index < len(slice) {
		newSlice = append(slice[:index], slice[index+1:]...)
	} else {
		newSlice = append(newSlice, slice...)
	}

	return newSlice
}
