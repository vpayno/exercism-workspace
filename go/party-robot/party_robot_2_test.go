package partyrobot

import (
	"fmt"
)

func ExampleWelcome() {
	fmt.Println(Welcome("Christiane"))
	// Output:
	// Welcome to my party, Christiane!
}

func ExampleHappyBirthday() {
	fmt.Println(HappyBirthday("Frank", 58))
	// Output:
	// Happy birthday Frank! You are now 58 years old!
}

func ExampleAssignTable() {
	fmt.Println(AssignTable("Christiane", 27, "Frank", "on the left", 23.7834298))
	// Output:
	// Welcome to my party, Christiane!
	// You have been assigned to table 027. Your table is on the left, exactly 23.8 meters from here.
	// You will be sitting next to Frank.
}
