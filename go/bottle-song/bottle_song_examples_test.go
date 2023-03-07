package bottlesong

import (
	"fmt"
)

func ExampleVerse() {
	fmt.Println(Verse(99))
	fmt.Println()

	fmt.Println(Verse(0))
	fmt.Println()

	fmt.Println(Verse(10))
	fmt.Println()

	fmt.Println(Verse(5))
	fmt.Println()

	fmt.Println(Verse(1))
	fmt.Println()

	// Output:
	// you can't have more than 10 bottles
	//
	//  you can't have zero or less bottles
	//
	// Ten green bottles hanging on the wall,
	// Ten green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be nine green bottles hanging on the wall.
	//  <nil>
	//
	// Five green bottles hanging on the wall,
	// Five green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be four green bottles hanging on the wall.
	//  <nil>
	//
	// One green bottle hanging on the wall,
	// One green bottle hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be no green bottles hanging on the wall.
	//  <nil>
	//
}

func ExampleVerses() {
	fmt.Println(Verses(10, 10))
	// Output:
	// Ten green bottles hanging on the wall,
	// Ten green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be nine green bottles hanging on the wall.
	//
	// Nine green bottles hanging on the wall,
	// Nine green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be eight green bottles hanging on the wall.
	//
	// Eight green bottles hanging on the wall,
	// Eight green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be seven green bottles hanging on the wall.
	//
	// Seven green bottles hanging on the wall,
	// Seven green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be six green bottles hanging on the wall.
	//
	// Six green bottles hanging on the wall,
	// Six green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be five green bottles hanging on the wall.
	//
	// Five green bottles hanging on the wall,
	// Five green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be four green bottles hanging on the wall.
	//
	// Four green bottles hanging on the wall,
	// Four green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be three green bottles hanging on the wall.
	//
	// Three green bottles hanging on the wall,
	// Three green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be two green bottles hanging on the wall.
	//
	// Two green bottles hanging on the wall,
	// Two green bottles hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be one green bottle hanging on the wall.
	//
	// One green bottle hanging on the wall,
	// One green bottle hanging on the wall,
	// And if one green bottle should accidentally fall,
	// There'll be no green bottles hanging on the wall.
	//  <nil>
}

func ExampleRecite() {
	fmt.Println(Recite(1, 2))
	fmt.Println()

	fmt.Println(Recite(1, 0))
	fmt.Println()

	fmt.Println(Recite(0, 1))
	fmt.Println()

	for i := 10; i > 0; i-- {
		fmt.Println(Recite(i, 1))
		fmt.Println()
	}
	// Output:
	// []
	//
	// []
	//
	// []
	//
	// [Ten green bottles hanging on the wall, Ten green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be nine green bottles hanging on the wall.]
	//
	// [Nine green bottles hanging on the wall, Nine green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be eight green bottles hanging on the wall.]
	//
	// [Eight green bottles hanging on the wall, Eight green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be seven green bottles hanging on the wall.]
	//
	// [Seven green bottles hanging on the wall, Seven green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be six green bottles hanging on the wall.]
	//
	// [Six green bottles hanging on the wall, Six green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be five green bottles hanging on the wall.]
	//
	// [Five green bottles hanging on the wall, Five green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be four green bottles hanging on the wall.]
	//
	// [Four green bottles hanging on the wall, Four green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be three green bottles hanging on the wall.]
	//
	// [Three green bottles hanging on the wall, Three green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be two green bottles hanging on the wall.]
	//
	// [Two green bottles hanging on the wall, Two green bottles hanging on the wall, And if one green bottle should accidentally fall, There'll be one green bottle hanging on the wall.]
	//
	// [One green bottle hanging on the wall, One green bottle hanging on the wall, And if one green bottle should accidentally fall, There'll be no green bottles hanging on the wall.]
}
