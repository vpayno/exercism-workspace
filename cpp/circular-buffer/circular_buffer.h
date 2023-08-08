#if !defined(CIRCULAR_BUFFER_H)
#define CIRCULAR_BUFFER_H

// please use c+ header files (*.hpp) instead of c header files (*.h)

#include <iostream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

namespace circular_buffer {

// set to true to enable debug output during tests
const bool k_debug_flag{false};

using number_t = int;
using text_t = std::string;

template <typename T>
using buffer_t =
    std::vector<T>; // note: for std::array, we need <T, S> instead of <T>

template <typename T> struct circular_buffer {
  public:
    circular_buffer() = delete; // not default-constructible
    circular_buffer(size_t capacity);

    [[nodiscard]] T read();

    void clear();
    void overwrite(T item);
    void write(T item);

  private:
    buffer_t<T> _buffer{};

    void advance_overwrite();
    void advance_write();
    void advance_read();

    size_t _unread{0};
    size_t _capacity{0};
    size_t _read_ptr{0};
    size_t _write_ptr{0};
};

template <typename T> text_t vector_to_string(buffer_t<T> buffer);

} // namespace circular_buffer

#endif // CIRCULAR_BUFFER_H
