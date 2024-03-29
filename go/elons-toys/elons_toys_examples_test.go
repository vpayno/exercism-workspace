package elon

import (
	"fmt"
)

func ExampleCar_Drive() {
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

func ExampleCar_DisplayDistance() {
	speed := 5
	batteryDrain := 2
	car := NewCar(speed, batteryDrain)

	fmt.Println(car.DisplayDistance())
	// Output:
	// Driven 0 meters
}

func ExampleCar_DisplayBattery() {
	speed := 5
	batteryDrain := 2
	car := NewCar(speed, batteryDrain)

	fmt.Println(car.DisplayBattery())
	// Output:
	// Battery at 100%
}

func ExampleCar_CanFinish() {
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
