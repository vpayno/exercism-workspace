package beer

import (
	"fmt"
)

func ExampleVerse() {
	fmt.Println(Verse(99))
	fmt.Println(Verse(2))
	fmt.Println(Verse(1))
	fmt.Println(Verse(0))
	// Output:
	// 99 bottles of beer on the wall, 99 bottles of beer.
	// Take one down and pass it around, 98 bottles of beer on the wall.
	//  <nil>
	// 2 bottles of beer on the wall, 2 bottles of beer.
	// Take one down and pass it around, 1 bottle of beer on the wall.
	//  <nil>
	// 1 bottle of beer on the wall, 1 bottle of beer.
	// Take it down and pass it around, no more bottles of beer on the wall.
	//  <nil>
	// No more bottles of beer on the wall, no more bottles of beer.
	// Go to the store and buy some more, 99 bottles of beer on the wall.
	//  <nil>
}

func ExampleVerses() {
	fmt.Println(Verses(91, 89))
	// Output:
	// 91 bottles of beer on the wall, 91 bottles of beer.
	// Take one down and pass it around, 90 bottles of beer on the wall.
	//
	// 90 bottles of beer on the wall, 90 bottles of beer.
	// Take one down and pass it around, 89 bottles of beer on the wall.
	//
	// 89 bottles of beer on the wall, 89 bottles of beer.
	// Take one down and pass it around, 88 bottles of beer on the wall.
	//
	//  <nil>
}
