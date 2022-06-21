package expenses

import "fmt"

func ExampleFilter() {
	records := []Record{
		{Day: 1, Amount: 15, Category: "groceries"},
		{Day: 11, Amount: 300, Category: "utility-bills"},
		{Day: 12, Amount: 28, Category: "groceries"},
		{Day: 26, Amount: 300, Category: "university"},
		{Day: 28, Amount: 1300, Category: "rent"},
	}

	predicate := func(record Record) bool {
		return record.Day == 1
	}

	fmt.Printf("%#v\n", Filter(records, predicate))
	// Output:
	// []expenses.Record{expenses.Record{Day:1, Amount:15, Category:"groceries"}}
}

func ExampleByDaysPeriod() {
	records := []Record{
		{Day: 1, Amount: 15, Category: "groceries"},
		{Day: 11, Amount: 300, Category: "utility-bills"},
		{Day: 12, Amount: 28, Category: "groceries"},
		{Day: 26, Amount: 300, Category: "university"},
		{Day: 28, Amount: 1300, Category: "rent"},
	}

	period := DaysPeriod{From: 1, To: 15}

	results := Filter(records, ByDaysPeriod(period))

	fmt.Println("[")
	for _, result := range results {
		fmt.Printf(" %#v,\n", result)
	}
	fmt.Println("]")
	// Output:
	// [
	//  expenses.Record{Day:1, Amount:15, Category:"groceries"},
	//  expenses.Record{Day:11, Amount:300, Category:"utility-bills"},
	//  expenses.Record{Day:12, Amount:28, Category:"groceries"},
	// ]
}

func ExampleByCategory() {
	records := []Record{
		{Day: 1, Amount: 15, Category: "groceries"},
		{Day: 11, Amount: 300, Category: "utility-bills"},
		{Day: 12, Amount: 28, Category: "groceries"},
		{Day: 26, Amount: 300, Category: "university"},
		{Day: 28, Amount: 1300, Category: "rent"},
	}

	results := Filter(records, ByCategory("groceries"))

	fmt.Println("[")
	for _, result := range results {
		fmt.Printf(" %#v,\n", result)
	}
	fmt.Println("]")
	// Output:
	// [
	//  expenses.Record{Day:1, Amount:15, Category:"groceries"},
	//  expenses.Record{Day:12, Amount:28, Category:"groceries"},
	// ]
}

func ExampleTotalByPeriod() {
	records := []Record{
		{Day: 15, Amount: 16, Category: "entertainment"},
		{Day: 32, Amount: 20, Category: "groceries"},
		{Day: 40, Amount: 30, Category: "entertainment"},
	}

	p1 := DaysPeriod{From: 1, To: 30}
	p2 := DaysPeriod{From: 31, To: 60}

	fmt.Println(TotalByPeriod(records, p1))
	fmt.Println(TotalByPeriod(records, p2))
	// Output:
	// 16
	// 50
}

func ExampleCategoryExpenses() {
	records := []Record{
		{Day: 1, Amount: 15, Category: "groceries"},
		{Day: 11, Amount: 300, Category: "utility-bills"},
		{Day: 12, Amount: 28, Category: "groceries"},
		{Day: 26, Amount: 300, Category: "university"},
		{Day: 28, Amount: 1300, Category: "rent"},
	}

	p1 := DaysPeriod{From: 1, To: 30}
	p2 := DaysPeriod{From: 31, To: 60}

	t, e := CategoryExpenses(records, p1, "entertainment")
	fmt.Printf("total: %v, error: %#v\n", t, e)
	t, e = CategoryExpenses(records, p1, "rent")
	fmt.Printf("total: %v, error: %#v\n", t, e)
	t, e = CategoryExpenses(records, p2, "rent")
	fmt.Printf("total: %v, error: %#v\n", t, e)
	// Output:
	// total: 0, error: &errors.errorString{s:"unknown category"}
	// total: 1300, error: <nil>
	// total: 0, error: <nil>
}
