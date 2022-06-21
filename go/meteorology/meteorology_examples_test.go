package meteorology

import "fmt"

func ExampleTemperatureUnitString() {
	celsiusUnit := Celsius
	fahrenheitUnit := Fahrenheit

	fmt.Println(celsiusUnit)
	fmt.Println(fahrenheitUnit)
	// Output:
	// °C
	// °F
}

func ExampleTemperatureString() {
	celsiusTemp := Temperature{
		degree: 21,
		unit:   Celsius,
	}

	fahrenheitTemp := Temperature{
		degree: 75,
		unit:   Fahrenheit,
	}

	fmt.Println(celsiusTemp)
	fmt.Println(fahrenheitTemp)
	// Output:
	// 21 °C
	// 75 °F
}

func ExampleSpeedUnitString() {
	mphUnit := MilesPerHour
	kmhUnit := KmPerHour

	fmt.Println(mphUnit)
	fmt.Println(kmhUnit)
	// Output:
	// mph
	// km/h
}

func ExampleSpeedString() {
	windSpeed := Speed{
		magnitude: 18,
		unit:      KmPerHour,
	}
	fmt.Println(windSpeed)

	windSpeed = Speed{
		magnitude: 36,
		unit:      MilesPerHour,
	}
	fmt.Println(windSpeed)
	// Output:
	// 18 km/h
	// 36 mph
}

func ExampleMeteorologyDataString() {

	sfData := MeteorologyData{
		location: "San Francisco",
		temperature: Temperature{
			degree: 57,
			unit:   Fahrenheit,
		},
		windDirection: "NW",
		windSpeed: Speed{
			magnitude: 19,
			unit:      MilesPerHour,
		},
		humidity: 60,
	}

	fmt.Println(sfData)
	// Output:
	// San Francisco: 57 °F, Wind NW at 19 mph, 60% Humidity
}
