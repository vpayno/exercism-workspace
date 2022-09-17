// Package linkedlist implements a singly linked list.
package linkedlist

import "errors"

// Element holds data and a pointer to the next Element.
type Element struct {
	data int
	next *Element
}

// List holds the 1st element of the list and the size of the list.
type List struct {
	head *Element
	tail *Element
	curr *Element
	size int
}

// New returns a new list that is populated using the passed slice/array.
func New(slice []int) *List {
	list := &List{
		head: nil,
		tail: nil,
		curr: nil,
		size: 0,
	}

	if len(slice) == 0 {
		return list
	}

	for _, d := range slice {
		list.Push(d)
	}

	return list
}

// Size returns the size of the list.
func (l *List) Size() int {
	return l.size
}

// Next returns a pointer to the next item in the List.
func (l *List) Next() *Element {
	if l.head == nil || l.curr == nil {
		return nil
	}

	next := l.curr
	l.curr = l.curr.next

	return next
}

// Push add a new number to the end of the List.
func (l *List) Push(data int) {
	element := Element{
		data: data,
		next: nil,
	}

	switch {
	case l.head == nil:
		l.head = &element
		l.curr = l.head
		l.tail = l.head
	default:
		l.curr = l.head
		l.tail.next = &element
		l.tail = &element
	}

	l.size++
}

// Reset resets a List to it's zero value.
func (l *List) Reset() {
	l.head = nil
	l.curr = nil
	l.tail = nil
	l.size = 0
}

// Pop returns an interger and an error code from the last element of the List while also removing it.
func (l *List) Pop() (int, error) {
	if l.Size() == 0 {
		return 0, errors.New("can't pop an element from an empty list")
	}

	if l.Size() == 1 {
		data := l.head.data
		l.Reset()

		return data, nil
	}

	e := l.Next()

	for e.next != nil {
		if e.next.next == nil {
			break
		}
		e = l.Next()
	}

	data := e.next.data
	e.next = nil
	l.tail = e
	l.curr = l.head
	l.size--

	return data, nil
}

// Array returns the List as a slice.
func (l *List) Array() []int {
	if l.Size() == 0 {
		return []int{}
	}

	slice := []int{}

	e := l.Next()

	if e != nil {
		for e.next != nil {
			slice = append(slice, e.data)
			e = l.Next()
		}
		slice = append(slice, e.data)
	}

	return slice
}

// Reverse returns a new List in reversed order.
func (l *List) Reverse() *List {
	if l.Size() == 0 {
		return &List{}
	}

	fSlice := l.Array()
	rSlice := []int{}

	for i := range fSlice {
		rSlice = append(rSlice, fSlice[len(fSlice)-1-i])
	}

	rList := New(rSlice)

	return rList
}
