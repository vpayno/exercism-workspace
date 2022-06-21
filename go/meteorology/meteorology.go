package meteorology

import "fmt"

// TemperatureUnit Enum declaration.
type TemperatureUnit int

// Temperature Units Enum definitions.
const (
	Celsius    TemperatureUnit = 0
	Fahrenheit TemperatureUnit = 1
)

// TemperatureUnit String() method that returns a human readable temperature unit.
func (index TemperatureUnit) String() string {
	units := []string{"°C", "°F"}
	return units[index]
}

// Temperature type tracks temperature value and unit type.
type Temperature struct {
	degree int
	unit   TemperatureUnit
}

// Temperature String() method that returns a human readable temperature reading.
func (t Temperature) String() string {
	return fmt.Sprintf("%v %v", t.degree, t.unit)
}

// SpeedUnit Emum declaration.
type SpeedUnit int

// Speed Unit Enum definitions.
const (
	KmPerHour    SpeedUnit = 0
	MilesPerHour SpeedUnit = 1
)

// SpeedUnit String() method that returns a human readable speed unit.
func (index SpeedUnit) String() string {
	units := []string{"km/h", "mph"}
	return units[index]
}

// Speed type tracks wind speed value and unit type.
type Speed struct {
	magnitude int
	unit      SpeedUnit
}

// Speed String() method that returns a human readable speed reading.
func (s Speed) String() string {
	return fmt.Sprintf("%v %v", s.magnitude, s.unit)
}

// MeteorologyData type tracks location weather information.
type MeteorologyData struct {
	location      string
	temperature   Temperature
	windDirection string
	windSpeed     Speed
	humidity      int
}

// MeteorologyData String() method that returns a human readable meteorology reading.
func (md MeteorologyData) String() string {
	var s string

	s = fmt.Sprintf("%s: %d %s, ", md.location, md.temperature.degree, md.temperature.unit)
	s += fmt.Sprintf("Wind %s at %d %s, ", md.windDirection, md.windSpeed.magnitude, md.windSpeed.unit)
	s += fmt.Sprintf("%d%% Humidity", md.humidity)

	return s
}
