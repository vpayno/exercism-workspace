package thefarm

import (
	"errors"
	"fmt"
)

// See types.go for the types defined for this exercise.

// SillyNephewError struct for catching negative cow counts.
type SillyNephewError struct {
	cows int
}

func (e *SillyNephewError) Error() string {
	return fmt.Sprintf("silly nephew, there cannot be %d cows", e.cows)
}

// ErrNegativeFodder indicates that we owe fodder???
var ErrNegativeFodder = errors.New("negative fodder")

// ErrDivisionByZero indicates a divide by zero error.
var ErrDivisionByZero = errors.New("division by zero")

// DivideFood computes the fodder amount per cow for the given cows.
func DivideFood(weightFodder WeightFodder, cows int) (float64, error) {
	fodder, e := weightFodder.FodderAmount()
	var retVal float64 = 0
	var retErr error = nil

	if cows == 0 {
		// Prevent division by zero cows.
		e = ErrDivisionByZero
		retVal, retErr = 0, e
	} else if cows < 0 {
		// Handle negative cow reporting.
		e = &SillyNephewError{cows: cows}
		retVal, retErr = 0, e
	} else if fodder < 0 {
		// We can't divide food we don't have.
		if e == ErrScaleMalfunction || e == nil {
			e = ErrNegativeFodder
		}
		retVal, retErr = 0, e
	} else {
		// Default feeder action.
		retVal, retErr = fodder/float64(cows), nil
	}

	// For error ErrScaleMalfunction, multiply fodder by 2 before dividing
	// evenly between the cows and return nil for the error.
	// For all other errors, fail.
	if e == ErrScaleMalfunction {
		retVal, retErr = retVal*2.0, nil
	} else if e != nil {
		if retVal != 0 {
			// For remaining unhandled errors.
			retVal, retErr = 0, e
		}
	}

	return retVal, retErr
}
