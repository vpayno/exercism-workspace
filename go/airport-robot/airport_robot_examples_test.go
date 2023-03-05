package airportrobot

import "fmt"

func ExampleSayHello() {
	fmt.Println(SayHello("Dietrich", German{}))
	// Output:
	// I can speak German: Hallo Dietrich!
}
