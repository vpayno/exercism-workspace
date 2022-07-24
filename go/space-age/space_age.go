package space

// Planet is a string with the name of a Planet.
type Planet string

// orbitalPeriods is map of the planets and their orbital periods.
var orbitalPeriods map[Planet]float64 = map[Planet]float64{
	"Mercury": 0.2408467,
	"Venus":   0.61519726,
	"Earth":   1.0,
	"Mars":    1.8808158,
	"Jupiter": 11.862615,
	"Saturn":  29.447498,
	"Uranus":  84.016846,
	"Neptune": 164.79132,
}

// secondsInEarthYear is the number of seconds in an Earth year that's 365.25 years long.
var secondsInEarthYear float64 = 365.25 * 24 * 60 * 60

// Age returns a person's age on a given planet.
func Age(seconds float64, planet Planet) float64 {
	orbitalPeriod, found := orbitalPeriods[planet]

	if !found {
		return -1.0
	}

	age := seconds / (orbitalPeriod * secondsInEarthYear)

	return age
}
