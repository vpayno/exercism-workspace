#include "simple_linked_list.hpp"

namespace simple_linked_list {

std::size_t List::size() const {
    // Return the correct size of the list.
    return _current_size;
}

void List::push(int entry) {
    // Implement a function that pushes an Element with `entry` as data to the
    // front of the list.
    if (_head == nullptr) {
        _head = new Element(entry);
    } else {
        auto *new_head = new Element(entry);

        new_head->next = _head;
        _head = new_head;
    }

    _current_size++;
}

int List::pop() {
    // Implement a function that returns the data value of the first element in
    // the list then discard that element.
    if (_head == nullptr) {
        throw std::runtime_error("List is empty");
    }

    const int data = _head->data;
    Element *old_head = _head;
    _head = _head->next;

    delete old_head;

    _current_size--;

    return data;
}

void List::reverse() {
    // Implement a function to reverse the order of the elements in the list.
    if (_head == nullptr) {
        return;
    }

    auto *iter_next = _head->next;
    _head->next = nullptr;
    while (iter_next != nullptr) {
        auto *next = iter_next->next;
        iter_next->next = _head;
        _head = iter_next;
        iter_next = next;
    }
}

List::~List() {
    // Ensure that all resources are freed on destruction
    Element *current = _head;
    while (current != nullptr) {
        Element *next = current->next;
        delete current;
        current = next;
    }
}

} // namespace simple_linked_list
