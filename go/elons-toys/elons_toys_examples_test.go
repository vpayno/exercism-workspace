package elon

import (
	"fmt"
)

func ExampleDrive() {
	speed := 5
	batteryDrain := 2
	car := NewCar(speed, batteryDrain)

	fmt.Println(car.Drive())
	fmt.Printf("%+v\n", car)

	car.battery = 0
	fmt.Println(car.Drive())
	fmt.Printf("%+v\n", car)
	// Output:
	// true
	// &{speed:5 batteryDrain:2 battery:98 distance:5}
	// false
	// &{speed:5 batteryDrain:2 battery:0 distance:5}
}

func ExampleDisplayDistance() {
	speed := 5
	batteryDrain := 2
	car := NewCar(speed, batteryDrain)

	fmt.Println(car.DisplayDistance())
	// Output:
	// Driven 0 meters
}

func ExampleDisplayBattery() {
	speed := 5
	batteryDrain := 2
	car := NewCar(speed, batteryDrain)

	fmt.Println(car.DisplayBattery())
	// Output:
	// Battery at 100%
}

func ExampleCanFinish() {
	speed := 5
	batteryDrain := 2
	car := NewCar(speed, batteryDrain)

	trackDistance := 100

	fmt.Println(car.CanFinish(trackDistance))

	car.battery = 30
	fmt.Println(car.CanFinish(trackDistance))
	// Output:
	// true
	// false
}
