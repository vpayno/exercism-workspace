package interest

import (
	"fmt"
)

func ExampleInterestRate() {
	fmt.Println(InterestRate(-123.45))
	fmt.Println(InterestRate(200.75))
	fmt.Println(InterestRate(2_000.25))
	fmt.Println(InterestRate(7_000.50))
	// Output:
	// 3.213
	// 0.5
	// 1.621
	// 2.475
}

func ExampleInterest() {
	fmt.Printf("%.6f\n", Interest(-123.45))
	fmt.Printf("%.6f\n", Interest(200.75))
	fmt.Printf("%.6f\n", Interest(2_000.25))
	fmt.Printf("%.6f\n", Interest(7_000.50))
	// Output:
	// -3.966448
	// 1.003750
	// 32.424054
	// 173.262374
}

func ExampleAnnualBalanceUpdate() {
	fmt.Printf("%.6f\n", AnnualBalanceUpdate(-123.45))
	fmt.Printf("%.6f\n", AnnualBalanceUpdate(200.75))
	fmt.Printf("%.6f\n", AnnualBalanceUpdate(2_000.25))
	fmt.Printf("%.6f\n", AnnualBalanceUpdate(7_000.50))
	// Output:
	// -127.416448
	// 201.753750
	// 2032.674054
	// 7173.762374
}

func ExampleYearsBeforeDesiredBalance() {
	balance := 200.75
	targetBalance := 214.88
	fmt.Println(YearsBeforeDesiredBalance(balance, targetBalance))
	// Output:
	// 14
}
