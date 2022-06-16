// Package weather is a library for forcasting weather conditions in various cities in Goblinocus.
package weather

// CurrentCondition stores the current weather conditions for a city.
var CurrentCondition string

// CurrentLocation stores the current city we're forcasting for.
var CurrentLocation string

// Forecast returns a string with the weather conditions for a city.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
