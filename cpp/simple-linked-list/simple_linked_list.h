#if !defined(SIMPLE_LINKED_LIST_H)
#define SIMPLE_LINKED_LIST_H

#include <stdexcept>

namespace simple_linked_list {

class List {
  public:
    List() = default;
    ~List();

    // Moving and copying is not needed to solve the exercise.
    // If you want to change these, make sure to correctly
    // free / move / copy the allocated resources.
    List(const List &) = delete;
    List &operator=(const List &) = delete;
    List(List &&) = delete;
    List &operator=(List &&) = delete;

    [[nodiscard]] std::size_t size() const;
    void push(int entry);
    int pop();
    void reverse();

  private:
    struct Element {
      public:
        Element(int data) : data{data} {};
        Element *next{nullptr};
        int data{};
    };

    Element *_head{nullptr};
    std::size_t _current_size{0};
};

} // namespace simple_linked_list

#endif
