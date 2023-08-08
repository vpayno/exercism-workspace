#include "circular_buffer.h"

template struct circular_buffer::circular_buffer<circular_buffer::number_t>;
template struct circular_buffer::circular_buffer<circular_buffer::text_t>;

namespace circular_buffer {

template <typename T>
circular_buffer<T>::circular_buffer(size_t capacity) : _capacity(capacity) {
    clear();
}

template <typename T> void circular_buffer<T>::clear() {
    _unread = 0;
    _read_ptr = 0;
    _write_ptr = 0;
    _buffer.clear();
    _buffer.resize(_capacity);
    std::fill(_buffer.begin(), _buffer.end(), 0);
}

template <typename T> void circular_buffer<T>::overwrite(T item) {
    std::cout << "overwriting: old[" << _buffer.at(_read_ptr) << "] with ["
              << item << "]" << std::endl;

    if (_unread < _capacity) {
        write(item);
        return;
    }

    _buffer[_read_ptr] = item;
    advance_overwrite();
}

template <typename T> void circular_buffer<T>::advance_overwrite() {
    _read_ptr = (_read_ptr + 1) % _capacity;
}

template <typename T> void circular_buffer<T>::write(T item) {
    if (_unread + 1 > _capacity) {
        throw std::domain_error("circular buffer is full");
    }

    _buffer[_write_ptr] = item;
    advance_write();

    std::cout << "writing: [" << item << "]" << std::endl;
}

template <typename T> void circular_buffer<T>::advance_write() {
    _write_ptr = (_write_ptr + 1) % _capacity;
    _unread += 1;
}

template <typename T> T circular_buffer<T>::read() {
    if (_unread == 0) {
        throw std::domain_error("circular buffer is empty");
    }

    T item = _buffer.at(_read_ptr);

    advance_read();

    std::cout << "buffer: " << vector_to_string(_buffer) << std::endl;
    std::cout << "reading: [" << _read_ptr << "]" << std::endl;

    return item;
}

template <typename T> void circular_buffer<T>::advance_read() {
    _read_ptr = (_read_ptr + 1) % _capacity;
    _unread -= 1;
}

template <typename T> text_t vector_to_string(buffer_t<T> buffer) {
    std::stringstream output{};

    size_t tracker{buffer.size() - 1};

    output << "[ ";
    for (auto iter : buffer) {
        output << iter;

        if (--tracker == 0) {
            output << ", ";
        }
    }
    output << " ]";

    return output.str();
}

} // namespace circular_buffer
