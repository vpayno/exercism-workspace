<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# annalyn

```go
import "annalyn"
```

## Index

- [func CanFastAttack(knightIsAwake bool) bool](<#func-canfastattack>)
- [func CanFreePrisoner(knightIsAwake, archerIsAwake, prisonerIsAwake, petDogIsPresent bool) bool](<#func-canfreeprisoner>)
- [func CanSignalPrisoner(archerIsAwake, prisonerIsAwake bool) bool](<#func-cansignalprisoner>)
- [func CanSpy(knightIsAwake, archerIsAwake, prisonerIsAwake bool) bool](<#func-canspy>)


## func [CanFastAttack](<https://github.com/vpayno/exercism-workspace/blob/main/go/annalyns-infiltration/annalyns_infiltration.go#L4>)

```go
func CanFastAttack(knightIsAwake bool) bool
```

CanFastAttack can be executed only when the knight is sleeping

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(CanFastAttack(true))

}
```

#### Output

```
false
```

</p>
</details>

## func [CanFreePrisoner](<https://github.com/vpayno/exercism-workspace/blob/main/go/annalyns-infiltration/annalyns_infiltration.go#L20>)

```go
func CanFreePrisoner(knightIsAwake, archerIsAwake, prisonerIsAwake, petDogIsPresent bool) bool
```

CanFreePrisoner can be executed if the prisoner is awake and the other 2 characters are asleep or if Annalyn's pet dog is with her and the archer is sleeping

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(CanFreePrisoner(false, true, false, false))

}
```

#### Output

```
false
```

</p>
</details>

## func [CanSignalPrisoner](<https://github.com/vpayno/exercism-workspace/blob/main/go/annalyns-infiltration/annalyns_infiltration.go#L14>)

```go
func CanSignalPrisoner(archerIsAwake, prisonerIsAwake bool) bool
```

CanSignalPrisoner can be executed if the prisoner is awake and the archer is sleeping

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(CanSignalPrisoner(false, true))

}
```

#### Output

```
true
```

</p>
</details>

## func [CanSpy](<https://github.com/vpayno/exercism-workspace/blob/main/go/annalyns-infiltration/annalyns_infiltration.go#L9>)

```go
func CanSpy(knightIsAwake, archerIsAwake, prisonerIsAwake bool) bool
```

CanSpy can be executed if at least one of the characters is awake

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(CanSpy(false, true, false))

}
```

#### Output

```
true
```

</p>
</details>



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)
