package linkedlist

import "fmt"

func ExampleList_new() {
	slice := []int{0, 1, 2, 3, 4}
	list := New(slice)

	fmt.Printf("slice: %#v\n", slice)
	fmt.Printf("list.head.data: %v\n", list.head.data)
	fmt.Printf("list.tail.data: %v\n", list.tail.data)
	fmt.Printf("list.size: %d\n", list.size)
	// Output:
	// slice: []int{0, 1, 2, 3, 4}
	// list.head.data: 0
	// list.tail.data: 4
	// list.size: 5
}

func ExampleList_size() {
	slice := []int{0, 1, 2, 3, 4}
	list := New(slice)

	fmt.Printf("slice len: %d\n", len(slice))
	fmt.Printf(" list len: %d\n", list.Size())
	// Output:
	// slice len: 5
	//  list len: 5
}

func ExampleList_next() {
	slice := []int{0, 1, 2, 3, 4}
	list := New(slice)

	fmt.Printf("slice: %#v\n", slice)

	n := list.Next()
	for n != nil {
		d := n.data
		fmt.Printf("next: %d\n", d)
		n = list.Next()
	}
	// Output:
	// slice: []int{0, 1, 2, 3, 4}
	// next: 0
	// next: 1
	// next: 2
	// next: 3
	// next: 4
}

func ExampleList_push() {
	l1 := List{
		head: nil,
		tail: nil,
		curr: nil,
		size: 0,
	}

	fmt.Printf("(%d) %v, %v\n", l1.Size(), l1.head, l1.tail)
	l1.Push(0)

	fmt.Printf("(%d) %d, %d\n", l1.Size(), l1.head.data, l1.tail.data)
	l1.Push(1)

	fmt.Printf("(%d) %d, %d\n", l1.Size(), l1.head.next.data, l1.tail.data)
	l1.Push(2)

	fmt.Printf("(%d) %d, %d\n", l1.Size(), l1.head.next.next.data, l1.tail.data)
	l1.Push(3)

	fmt.Printf("(%d) %d, %d\n", l1.Size(), l1.head.next.next.next.data, l1.tail.data)
	l1.Push(4)

	fmt.Printf("(%d) %d, %d\n", l1.Size(), l1.head.next.next.next.next.data, l1.tail.data)

	// Output:
	// (0) <nil>, <nil>
	// (1) 0, 0
	// (2) 1, 1
	// (3) 2, 2
	// (4) 3, 3
	// (5) 4, 4
}

func ExampleList_pop() {
	slice := []int{0, 1, 2, 3, 4}
	list := New(slice)

	fmt.Printf("slice: %#v\n", slice)
	fmt.Printf("before: %d\n", list.tail.data)

	d, e := list.Pop()
	fmt.Printf("popped: %d, %v\n", d, e)
	fmt.Printf("after: %d\n", list.tail.data)

	d, e = list.Pop()
	fmt.Printf("popped: %d, %v\n", d, e)
	fmt.Printf("after: %d\n", list.tail.data)

	d, e = list.Pop()
	fmt.Printf("popped: %d, %v\n", d, e)
	fmt.Printf("after: %d\n", list.tail.data)

	d, e = list.Pop()
	fmt.Printf("popped: %d, %v\n", d, e)
	fmt.Printf("after: %d\n", list.tail.data)

	d, e = list.Pop()
	fmt.Printf("popped: %d, %v\n", d, e)

	// Output:
	// slice: []int{0, 1, 2, 3, 4}
	// before: 4
	// popped: 4, <nil>
	// after: 3
	// popped: 3, <nil>
	// after: 2
	// popped: 2, <nil>
	// after: 1
	// popped: 1, <nil>
	// after: 0
	// popped: 0, <nil>
}

func ExampleList_array() {
	s1 := []int{0, 1, 2, 3, 4}
	list := New(s1)
	s2 := list.Array()

	fmt.Printf("s1: %#v\n", s1)
	fmt.Printf("s2: %#v\n", s2)
	// Output:
	// s1: []int{0, 1, 2, 3, 4}
	// s2: []int{0, 1, 2, 3, 4}
}

func ExampleList_reverse() {
	s1 := []int{0, 1, 2, 3, 4}
	l1 := New(s1)
	l2 := l1.Reverse()
	s2 := l2.Array()

	fmt.Printf("s1: %#v\n", s1)
	fmt.Printf("s2: %#v\n", s2)
	// Output:
	// s1: []int{0, 1, 2, 3, 4}
	// s2: []int{4, 3, 2, 1, 0}
}
