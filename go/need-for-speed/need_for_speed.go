package speed

// Car struct
type Car struct {
	battery      int
	batteryDrain int
	speed        int
	distance     int
}

// NewCar creates a new remote controlled car with full battery and given specifications.
func NewCar(speed, batteryDrain int) Car {
	var car Car = Car{
		battery:      100,
		batteryDrain: batteryDrain,
		speed:        speed,
		distance:     0,
	}

	return car
}

// Track struct
type Track struct {
	distance int
}

// NewTrack created a new track
func NewTrack(distance int) Track {
	return Track{distance: distance}
}

// Drive drives the car one time. If there is not enough battery to drive on more time,
// the car will not move.
func Drive(car Car) Car {
	if car.battery >= car.batteryDrain {
		car.battery -= car.batteryDrain
		car.distance += car.speed
	}

	return car
}

// CanFinish checks if a car is able to finish a certain track.
func CanFinish(car Car, track Track) bool {
	var result bool
	var steps int

	steps = track.distance / car.speed
	if track.distance%car.speed > 0 {
		steps++
	}

	if steps*car.batteryDrain <= car.battery {
		result = true
	}

	return result
}

/*
Drive({battery:3 batteryDrain:7 speed:5 distance:0}) = {battery:-4 batteryDrain:7 speed:5 distance:5}; expected {battery:3 batteryDrain:7 speed:5 distance:0}
Drive({battery:4 batteryDrain:5 speed:5 distance:0}) = {battery:-1 batteryDrain:5 speed:5 distance:5}; expected {battery:4 batteryDrain:5 speed:5 distance:0}
Drive({battery:2 batteryDrain:3 speed:5 distance:1}) = {battery:-1 batteryDrain:3 speed:5 distance:6}; expected {battery:2 batteryDrain:3 speed:5 distance:1}
*/
