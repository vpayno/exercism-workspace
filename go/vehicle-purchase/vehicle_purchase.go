package purchase

import (
	"fmt"
)

// NeedsLicense determines whether a license is needed to drive a type of vehicle. Only "car" and "truck" require a license.
func NeedsLicense(kind string) bool {
	var result bool

	switch kind {
	case "car", "truck":
		result = true
	default:
		result = false
	}

	return result
}

// ChooseVehicle recommends a vehicle for selection. It always recommends the vehicle that comes first in lexicographical order.
func ChooseVehicle(option1, option2 string) string {
	var result string

	if option1 < option2 {
		result = option1
	} else {
		result = option2
	}

	return fmt.Sprintf("%s is clearly the better choice.", result)
}

// CalculateResellPrice calculates how much a vehicle can resell for at a certain age.
func CalculateResellPrice(originalPrice, age float64) float64 {
	var offset float64

	if age < 3 {
		offset = 0.80
	} else if age >= 3 && age < 10 {
		offset = 0.70
	} else {
		offset = 0.50
	}

	return originalPrice * offset
}
