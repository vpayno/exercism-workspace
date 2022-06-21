package cards

import (
	"fmt"
)

func ExampleFavoriteCards() {
	fmt.Println(FavoriteCards())
	// Output: [2 6 9]
}

func ExampleGetItem() {
	deck := []int{1, 2, 4, 1}
	fmt.Println(GetItem(deck, 2))

	deck = []int{1, 2, 4, 1}
	fmt.Println(GetItem(deck, 10))
	// Output:
	// 4
	// -1
}

func ExampleSetItem() {
	deck := []int{1, 2, 4, 1}
	index, newCard := 2, 6
	fmt.Println(SetItem(deck, index, newCard))

	deck = []int{1, 2, 4, 1}
	index, newCard = -1, 6
	fmt.Println(SetItem(deck, index, newCard))

	deck = []int{5, 2, 10, 6, 8, 7, 0, 9}
	index, newCard = 4, 1
	fmt.Println(SetItem(deck, index, newCard))

	deck = []int{5, 2, 10, 6, 8, 7, 0, 9}
	index, newCard = 0, 8
	fmt.Println(SetItem(deck, index, newCard))

	deck = []int{5, 2, 10, 6, 8, 7, 0, 9}
	index, newCard = 7, 8
	fmt.Println(SetItem(deck, index, newCard))
	// Output:
	// [1 2 6 1]
	// [1 2 4 1 6]
	// [5 2 10 6 1 7 0 9]
	// [8 2 10 6 8 7 0 9]
	// [5 2 10 6 8 7 0 8]
}

func ExamplePrependItems() {
	deck := []int{3, 2, 6, 4, 8}
	fmt.Println(PrependItems(deck, 5, 1))

	deck = []int{3, 2, 6, 4, 8}
	fmt.Println(PrependItems(deck))
	// Output:
	// [5 1 3 2 6 4 8]
	// [3 2 6 4 8]
}

func ExampleRemoveItem() {
	deck := []int{3, 2, 6, 4, 8}
	fmt.Println(RemoveItem(deck, 11))

	deck = []int{3, 2, 6, 4, 8}
	fmt.Println(RemoveItem(deck, 2))
	// Output:
	// [3 2 6 4 8]
	// [3 2 4 8]
}
