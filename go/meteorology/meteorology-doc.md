<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# meteorology

```go
import "meteorology"
```

## Index

- [type MeteorologyData](<#type-meteorologydata>)
  - [func (md MeteorologyData) String() string](<#func-meteorologydata-string>)
- [type Speed](<#type-speed>)
  - [func (s Speed) String() string](<#func-speed-string>)
- [type SpeedUnit](<#type-speedunit>)
  - [func (index SpeedUnit) String() string](<#func-speedunit-string>)
- [type Temperature](<#type-temperature>)
  - [func (t Temperature) String() string](<#func-temperature-string>)
- [type TemperatureUnit](<#type-temperatureunit>)
  - [func (index TemperatureUnit) String() string](<#func-temperatureunit-string>)


## type [MeteorologyData](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L58-L64>)

MeteorologyData type tracks location weather information.

```go
type MeteorologyData struct {
    // contains filtered or unexported fields
}
```

### func \(MeteorologyData\) [String](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L67>)

```go
func (md MeteorologyData) String() string
```

MeteorologyData String\(\) method that returns a human readable meteorology reading.

<details><summary>Example</summary>
<p>

```go
{

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

}
```

#### Output

```
San Francisco: 57 °F, Wind NW at 19 mph, 60% Humidity
```

</p>
</details>

## type [Speed](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L47-L50>)

Speed type tracks wind speed value and unit type.

```go
type Speed struct {
    // contains filtered or unexported fields
}
```

### func \(Speed\) [String](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L53>)

```go
func (s Speed) String() string
```

Speed String\(\) method that returns a human readable speed reading.

<details><summary>Example</summary>
<p>

```go
{
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

}
```

#### Output

```
18 km/h
36 mph
```

</p>
</details>

## type [SpeedUnit](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L32>)

SpeedUnit Emum declaration.

```go
type SpeedUnit int
```

Speed Unit Enum definitions.

```go
const (
    KmPerHour    SpeedUnit = 0
    MilesPerHour SpeedUnit = 1
)
```

### func \(SpeedUnit\) [String](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L41>)

```go
func (index SpeedUnit) String() string
```

SpeedUnit String\(\) method that returns a human readable speed unit.

<details><summary>Example</summary>
<p>

```go
{
	mphUnit := MilesPerHour
	kmhUnit := KmPerHour

	fmt.Println(mphUnit)
	fmt.Println(kmhUnit)

}
```

#### Output

```
mph
km/h
```

</p>
</details>

## type [Temperature](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L21-L24>)

Temperature type tracks temperature value and unit type.

```go
type Temperature struct {
    // contains filtered or unexported fields
}
```

### func \(Temperature\) [String](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L27>)

```go
func (t Temperature) String() string
```

Temperature String\(\) method that returns a human readable temperature reading.

<details><summary>Example</summary>
<p>

```go
{
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

}
```

#### Output

```
21 °C
75 °F
```

</p>
</details>

## type [TemperatureUnit](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L6>)

TemperatureUnit Enum declaration.

```go
type TemperatureUnit int
```

Temperature Units Enum definitions.

```go
const (
    Celsius    TemperatureUnit = 0
    Fahrenheit TemperatureUnit = 1
)
```

### func \(TemperatureUnit\) [String](<https://github.com/vpayno/exercism-workspace/blob/main/go/meteorology/meteorology.go#L15>)

```go
func (index TemperatureUnit) String() string
```

TemperatureUnit String\(\) method that returns a human readable temperature unit.

<details><summary>Example</summary>
<p>

```go
{
	celsiusUnit := Celsius
	fahrenheitUnit := Fahrenheit

	fmt.Println(celsiusUnit)
	fmt.Println(fahrenheitUnit)

}
```

#### Output

```
°C
°F
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
