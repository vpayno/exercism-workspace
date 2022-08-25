// Package allergies is used to identify a patient's allergies.
package allergies

import "sort"

const (
	eggs    uint = 1
	peanuts uint = 1 << iota
	shellfish
	strawberries
	tomatoes
	chocolate
	pollen
	cats
)

var allergyNames = map[uint]string{
	0b00000001: "eggs",
	0b00000010: "peanuts",
	0b00000100: "shellfish",
	0b00001000: "strawberries",
	0b00010000: "tomatoes",
	0b00100000: "chocolate",
	0b01000000: "pollen",
	0b10000000: "cats",
}

// AllergicTo returns true or false to each allergy test.
func AllergicTo(flags uint, name string) bool {
	if flags == 0 {
		return false
	}

	allergyFlags := map[string]uint{}

	for bits, name := range allergyNames {
		allergyFlags[name] = bits
	}

	allergyFlag, ok := allergyFlags[name]

	if !ok {
		// Why do so many exercisms lack error return values????
		return false
	}

	if (flags & allergyFlag) != 0 {
		return true
	}

	return false
}

// Allergies returns a list of allergies the patient is allergic to.
func Allergies(flags uint) []string {
	if flags == 0 {
		return []string{}
	}

	allergies := []string{}

	// walk through all the known allergies
	for _, name := range allergyNames {
		if AllergicTo(flags, name) {
			allergies = append(allergies, name)
		}
	}

	// We need this so we can sort the allergies array since tests need sorted, stable output.
	allergyFlags := map[string]uint{}
	for bits, name := range allergyNames {
		allergyFlags[name] = bits
	}

	sort.Slice(allergies, func(i, j int) bool {
		return allergyFlags[allergies[i]] < allergyFlags[allergies[j]]
	})

	return allergies
}
