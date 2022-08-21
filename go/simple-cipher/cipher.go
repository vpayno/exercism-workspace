package cipher

// The Cipher interface describes the Encode() and Decode() functions.
type Cipher interface {
	Encode(string) string
	Decode(string) string
}
