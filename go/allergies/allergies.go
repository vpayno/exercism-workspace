// Package allergies is used to identify a patient's allergies.
package allergies

import (
	"sort"
)

type allergy uint

const (
	eggs    allergy = 1
	peanuts allergy = 1 << iota
	shellfish
	strawberries
	tomatoes
	chocolate
	pollen
	cats
)

var allergyNames = map[allergy]string{
	eggs.Bits():         "eggs",
	peanuts.Bits():      "peanuts",
	shellfish.Bits():    "shellfish",
	strawberries.Bits(): "strawberries",
	tomatoes.Bits():     "tomatoes",
	chocolate.Bits():    "chocolate",
	pollen.Bits():       "pollen",
	cats.Bits():         "cats",
}

func (a allergy) String() string {
	name, ok := allergyNames[a]

	if !ok {
		return ""
	}

	return name
}

func (a allergy) Uint() uint {
	if a < 1 || a > 255 {
		return 0
	}

	return uint(a)
}

func (a allergy) Bits() allergy {
	if a < 1 || a > 255 {
		return 0
	}

	return a
}

// AllergicTo returns true or false to each allergy test.
func AllergicTo(flags allergy, flag allergy) bool {
	if flags == 0 {
		return false
	}

	if (flags & flag.Bits()) != 0 {
		return true
	}

	return false
}

// Allergies returns a list of allergies the patient is allergic to.
func Allergies(flags allergy) []string {
	if flags == 0 {
		return []string{}
	}

	allergies := []string{}

	// walk through all the known allergies
	for flag, _ := range allergyNames {
		if AllergicTo(flags, flag) {
			allergies = append(allergies, allergy(flag).String())
		}
	}

	// We need this so we can sort the allergies array since tests need sorted, stable output.
	allergyFlags := map[string]allergy{}
	for bits, name := range allergyNames {
		allergyFlags[name] = bits
	}

	sort.Slice(allergies, func(i, j int) bool {
		return allergyFlags[allergies[i]] < allergyFlags[allergies[j]]
	})

	return allergies
}
