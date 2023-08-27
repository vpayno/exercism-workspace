//! Exercise Url: <https://exercism.org/tracks/rust/exercises/simple-linked-list>

use std::iter::FromIterator;

pub struct SimpleLinkedList<T> {
    length: usize,
    head: Option<Box<Node<T>>>,
}

struct Node<T> {
    data: T,
    next: Option<Box<Node<T>>>,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self {
            length: 0,
            head: None,
        }
    }

    // You may be wondering why it's necessary to have is_empty()
    // when it can easily be determined from len().
    // It's good custom to have both because len() can be expensive for some types,
    // whereas is_empty() is almost always cheap.
    // (Also ask yourself whether len() is expensive for SimpleLinkedList)
    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }

    pub fn len(&self) -> usize {
        self.length
    }

    pub fn push(&mut self, element: T) {
        let new_head = Box::new(Node {
            data: element,
            next: self.head.take(),
        });
        self.head = Some(new_head);
        self.length += 1;
    }

    pub fn pop(&mut self) -> Option<T> {
        self.head.take().map(|node| {
            self.head = node.next;
            self.length -= 1;
            node.data
        })
    }

    pub fn peek(&self) -> Option<&T> {
        self.head.as_ref().map(|node| &node.data)
    }

    #[must_use]
    pub fn rev(self) -> SimpleLinkedList<T> {
        let mut rev_list = SimpleLinkedList::new();
        let mut next = self.head;

        while let Some(node) = next {
            rev_list.push(node.data);
            next = node.next;
        }

        rev_list
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut new_list = SimpleLinkedList::new();

        for element in iter {
            new_list.push(element);
        }

        new_list
    }
}

// In general, it would be preferable to implement IntoIterator for SimpleLinkedList<T>
// instead of implementing an explicit conversion to a vector. This is because, together,
// FromIterator and IntoIterator enable conversion between arbitrary collections.
// Given that implementation, converting to a vector is trivial:
//
// let vec: Vec<_> = simple_linked_list.into_iter().collect();
//
// The reason this exercise's API includes an explicit conversion to Vec<T> instead
// of IntoIterator is that implementing that interface is fairly complicated, and
// demands more of the student than we expect at this point in the track.

// I'm not sure why we're supposed to destroy the linked list when converting it,
// changed linked_list into immutable and not using pop().
impl<T> From<SimpleLinkedList<T>> for Vec<T> {
    fn from(linked_list: SimpleLinkedList<T>) -> Vec<T> {
        let mut new_vector: Vec<T> = Vec::new();
        let mut next = linked_list.head;

        while let Some(node) = next {
            new_vector.push(node.data);
            next = node.next;
        }

        // unreverse the vector
        new_vector.reverse();

        new_vector
    }
}
