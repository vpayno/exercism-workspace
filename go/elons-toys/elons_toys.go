package elon

import (
	"fmt"
)

// Drive updates the number of meters driven based on the car's speed (`int`), and
// reduces the battery (`int`) according to the battery drainage.
func (car *Car) Drive() bool {
	success := false

	if car.battery-car.batteryDrain >= 0 {
		car.battery -= car.batteryDrain
		car.distance += car.speed

		success = true
	}

	return success
}

// DisplayDistance returns the distance as displayed on the LED display as a `string`.
func (car *Car) DisplayDistance() string {
	return fmt.Sprintf("Driven %d meters", car.distance)
}

// DisplayBattery returns the battery percentage as displayed on the LED display as a `string`.
func (car *Car) DisplayBattery() string {
	return fmt.Sprintf("Battery at %d%%", car.battery)
}

// CanFinish returns true if the car can finish by testing the given trackDistance (`int`).
func (car *Car) CanFinish(trackDistance int) bool {
	batteryNeeded := int(float64(trackDistance) / float64(car.speed) * float64(car.batteryDrain))

	return batteryNeeded <= car.battery
}
