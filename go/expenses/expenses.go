package expenses

import "errors"

// Record represents an expense record.
type Record struct {
	Day      int
	Amount   float64
	Category string
}

// DaysPeriod represents a period of days for expenses.
type DaysPeriod struct {
	From int
	To   int
}

// Filter returns the records for which the predicate function returns true.
func Filter(in []Record, predicate func(Record) bool) []Record {
	var results []Record = []Record{}

	for _, record := range in {
		if predicate(record) {
			results = append(results, record)
		}
	}

	return results
}

// ByDaysPeriod returns predicate function that returns true when
// the day of the record is inside the period of day and false otherwise
func ByDaysPeriod(p DaysPeriod) func(Record) bool {
	predicate := func(r Record) bool {
		return p.From <= r.Day && p.To >= r.Day
	}

	return predicate
}

// ByCategory returns predicate function that returns true when
// the category of the record is the same as the provided category
// and false otherwise
func ByCategory(c string) func(Record) bool {
	predicate := func(r Record) bool {
		return r.Category == c
	}

	return predicate
}

// TotalByPeriod returns total amount of expenses for records
// inside the period p
func TotalByPeriod(in []Record, p DaysPeriod) float64 {
	var total float64

	pe := Filter(in, ByDaysPeriod(p))

	for _, record := range pe {
		total += record.Amount
	}

	return total
}

// CategoryExpenses returns total amount of expenses for records
// in category c that are also inside the period p.
// An error must be returned only if there are no records in the list that belong
// to the given category, regardless of period of time.
func CategoryExpenses(in []Record, p DaysPeriod, c string) (float64, error) {
	ce := Filter(in, ByCategory(c))

	var t float64 = 0
	var e error = nil

	if len(ce) == 0 {
		t, e = 0, errors.New("unknown category")
	} else {
		t, e = TotalByPeriod(ce, p), nil
	}

	return t, e
}
