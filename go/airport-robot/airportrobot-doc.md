<!-- Code generated by gomarkdoc. DO NOT EDIT -->

# airportrobot

```go
import "airportrobot"
```

Package airportrobot handles robot greetings.

## Index

- [func SayHello(name string, greeter Greeter) string](<#func-sayhello>)
- [type German](<#type-german>)
  - [func (s German) Greet(name string) string](<#func-german-greet>)
  - [func (s German) LanguageName() string](<#func-german-languagename>)
- [type Greeter](<#type-greeter>)
- [type Italian](<#type-italian>)
  - [func (s Italian) Greet(name string) string](<#func-italian-greet>)
  - [func (s Italian) LanguageName() string](<#func-italian-languagename>)
- [type Portuguese](<#type-portuguese>)
  - [func (s Portuguese) Greet(name string) string](<#func-portuguese-greet>)
  - [func (s Portuguese) LanguageName() string](<#func-portuguese-languagename>)


## func [SayHello](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L13>)

```go
func SayHello(name string, greeter Greeter) string
```

SayHello in many languates

<details><summary>Example</summary>
<p>

```go
{
	fmt.Println(SayHello("Dietrich", German{}))

}
```

#### Output

```
I can speak German: Hallo Dietrich!
```

</p>
</details>

## type [German](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L21>)

German language interface

```go
type German struct{}
```

### func \(German\) [Greet](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L29>)

```go
func (s German) Greet(name string) string
```

Greet implementation in German

### func \(German\) [LanguageName](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L24>)

```go
func (s German) LanguageName() string
```

LanguageName implementation in German

## type [Greeter](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L7-L10>)

Greeter language interface

```go
type Greeter interface {
    LanguageName() string
    Greet(name string) string
}
```

## type [Italian](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L35>)

Italian language interface

```go
type Italian struct{}
```

### func \(Italian\) [Greet](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L43>)

```go
func (s Italian) Greet(name string) string
```

Greet implementation in Italian

### func \(Italian\) [LanguageName](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L38>)

```go
func (s Italian) LanguageName() string
```

LanguageName implementation in Italian

## type [Portuguese](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L49>)

Portuguese language interface

```go
type Portuguese struct{}
```

### func \(Portuguese\) [Greet](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L57>)

```go
func (s Portuguese) Greet(name string) string
```

Greet implementation in Portuguese

### func \(Portuguese\) [LanguageName](<https://github.com/vpayno/exercism-workspace/blob/main/go/airport-robot/airport_robot.go#L52>)

```go
func (s Portuguese) LanguageName() string
```

LanguageName implementation in Portuguese



Generated by [gomarkdoc](<https://github.com/princjef/gomarkdoc>)