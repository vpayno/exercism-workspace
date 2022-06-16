package weather

import (
	"fmt"
)

func ExampleForecast() {
	fmt.Println(Forecast("Gotham", "muggy"))
	// Output:
	// Gotham - current weather condition: muggy
}
