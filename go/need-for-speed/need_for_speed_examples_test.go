package speed

import (
	"fmt"
)

func ExampleNewCar() {
	fmt.Printf("%+v\n", NewCar(5, 2))
	// Output: {battery:100 batteryDrain:2 speed:5 distance:0}
}

func ExampleNewTrack() {
	fmt.Printf("%+v\n", NewTrack(800))
	// Output: {distance:800}
}

func ExampleDrive() {
	newCar := NewCar(5, 2)
	fmt.Printf("%+v\n", Drive(newCar))
	// Output: {battery:98 batteryDrain:2 speed:5 distance:5}
}

func ExampleCanFinish() {
	car := NewCar(5, 2)
	track := NewTrack(100)
	fmt.Println(CanFinish(car, track))
	// Output: true
}
