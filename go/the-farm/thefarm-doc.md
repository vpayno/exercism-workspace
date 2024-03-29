<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# thefarm

```go
import "thefarm"
```

Package thefarm exercise is about Go Errors.

## Index

- [Variables](<#variables>)
- [func DivideFood(weightFodder WeightFodder, cows int) (float64, error)](<#func-dividefood>)
- [type SillyNephewError](<#type-sillynephewerror>)
  - [func (e *SillyNephewError) Error() string](<#func-sillynephewerror-error>)
- [type WeightFodder](<#type-weightfodder>)


## Variables

ErrDivisionByZero indicates a divide by zero error.

```go
var ErrDivisionByZero = errors.New("division by zero")
```

ErrNegativeFodder indicates that we owe fodder???

```go
var ErrNegativeFodder = errors.New("negative fodder")
```

ErrScaleMalfunction indicates an error with the scale.

```go
var ErrScaleMalfunction = errors.New("sensor error")
```

## func [DivideFood](<https://github.com/vpayno/exercism-workspace/blob/main/go/the-farm/the_farm.go#L27>)

```go
func DivideFood(weightFodder WeightFodder, cows int) (float64, error)
```

DivideFood computes the fodder amount per cow for the given cows.

## type [SillyNephewError](<https://github.com/vpayno/exercism-workspace/blob/main/go/the-farm/the_farm.go#L12-L14>)

SillyNephewError struct for catching negative cow counts.

```go
type SillyNephewError struct {
    // contains filtered or unexported fields
}
```

### func \(\*SillyNephewError\) [Error](<https://github.com/vpayno/exercism-workspace/blob/main/go/the-farm/the_farm.go#L16>)

```go
func (e *SillyNephewError) Error() string
```

## type [WeightFodder](<https://github.com/vpayno/exercism-workspace/blob/main/go/the-farm/types.go#L10-L12>)

WeightFodder returns the amount of available fodder.

```go
type WeightFodder interface {
    FodderAmount() (float64, error)
}
```



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
