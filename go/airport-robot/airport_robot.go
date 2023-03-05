// Package airportrobot handles robot greetings.
package airportrobot

import "fmt"

// Greeter language interface
type Greeter interface {
	LanguageName() string
	Greet(name string) string
}

// SayHello in many languates
func SayHello(name string, greeter Greeter) string {
	language := greeter.LanguageName()
	greeting := greeter.Greet(name)
	response := fmt.Sprintf("I can speak %s: %s", language, greeting)
	return response
}

// German language interface
type German struct{}

// LanguageName implementation in German
func (s German) LanguageName() string {
	return "German"
}

// Greet implementation in German
func (s German) Greet(name string) string {
	response := fmt.Sprintf("%s %s!", "Hallo", name)
	return response
}

// Italian language interface
type Italian struct{}

// LanguageName implementation in Italian
func (s Italian) LanguageName() string {
	return "Italian"
}

// Greet implementation in Italian
func (s Italian) Greet(name string) string {
	response := fmt.Sprintf("%s %s!", "Ciao", name)
	return response
}

// Portuguese language interface
type Portuguese struct{}

// LanguageName implementation in Portuguese
func (s Portuguese) LanguageName() string {
	return "Portuguese"
}

// Greet implementation in Portuguese
func (s Portuguese) Greet(name string) string {
	response := fmt.Sprintf("%s %s!", "Olá", name)
	return response
}
