// Package flatten is used to flatten lists.
package flatten

// walkInterface uses a type switch to inspeact the list and recurse over nested lists.
func walkInterface(nested interface{}, result *[]interface{}) {
	switch nested.(type) {
	case int:
		*result = append(*result, nested)
	case []interface{}:
		for _, item := range nested.([]interface{}) {
			walkInterface(item, result)
		}
	}
}

// Flatten returns a single flattened list with all values except nil.
func Flatten(nested interface{}) []interface{} {
	result := make([]interface{}, 0)

	walkInterface(nested, &result)

	return result
}
