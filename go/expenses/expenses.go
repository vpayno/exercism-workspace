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
	var out []Record = []Record{}

	for _, record := range in {
		if predicate(record) {
			out = append(out, record)
		}
	}

	return out
}

// ByDaysPeriod returns predicate function that returns true when
// the day of the record is inside the period of day and false otherwise
func ByDaysPeriod(period DaysPeriod) func(Record) bool {
	predicate := func(record Record) bool {
		return period.From <= record.Day && period.To >= record.Day
	}

	return predicate
}

// ByCategory returns predicate function that returns true when
// the category of the record is the same as the provided category
// and false otherwise
func ByCategory(category string) func(Record) bool {
	predicate := func(record Record) bool {
		return record.Category == category
	}

	return predicate
}

// TotalByPeriod returns total amount of expenses for records
// inside the period p
func TotalByPeriod(in []Record, period DaysPeriod) float64 {
	var total float64

	expenses := Filter(in, ByDaysPeriod(period))

	for _, record := range expenses {
		total += record.Amount
	}

	return total
}

// CategoryExpenses returns total amount of expenses for records
// in category c that are also inside the period p.
// An error must be returned only if there are no records in the list that belong
// to the given category, regardless of period of time.
func CategoryExpenses(in []Record, period DaysPeriod, category string) (float64, error) {
	expenses := Filter(in, ByCategory(category))

	var total float64 = 0
	var err error = nil

	if len(expenses) == 0 {
		total, err = 0, errors.New("unknown category")
	} else {
		total, err = TotalByPeriod(expenses, period), nil
	}

	return total, err
}
