// Package census simulates a system used to collect census data.
package census

// Resident represents a resident in this city.
type Resident struct {
	Name    string
	Age     int
	Address map[string]string
}

// NewResident registers a new resident in this city.
func NewResident(name string, age int, address map[string]string) *Resident {
	// Should really copy the address map here.

	return &Resident{
		Name:    name,
		Age:     age,
		Address: address,
	}
}

// HasRequiredInfo determines if a given resident has all of the required information.
func (r *Resident) HasRequiredInfo() bool {
	var result bool = true

	// result = r.Name != "" || r.Age != 0 || len(r.Address) != 0

	street, hasStreet := r.Address["street"]

	if r.Name == "" {
		result = false
	} else if !hasStreet || street == "" {
		result = false
	}

	return result
}

// Delete deletes a resident's information.
func (r *Resident) Delete() {
	// r = nil

	*r = Resident{}
}

// Count counts all residents that have provided the required information.
func Count(residents []*Resident) int {
	var counter int

	for _, resident := range residents {
		if resident.HasRequiredInfo() {
			counter++
		}
	}

	return counter
}
