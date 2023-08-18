#if !defined(BINARY_SEARCH_TREE_H)
#define BINARY_SEARCH_TREE_H
#include <memory>
#include <string>

/*
 * binary_search_tree - declarations
 */
namespace binary_search_tree {

template <typename T> struct binary_tree {
  public:
    binary_tree(T data, binary_tree<T> *parent = nullptr);
    binary_tree(binary_tree &&tree);          // move constructor
    binary_tree(const binary_tree &tree_ref); // copy constructor
    ~binary_tree();

    using node_ptr_t = std::unique_ptr<binary_tree<T>>;

    binary_tree &operator=(binary_tree &&tree_ref); // move assignment operator
    binary_tree &operator=(binary_tree rhs);        // copy assignment operator
    bool operator<(const binary_tree &rhs);

    T &data();

    node_ptr_t &left();
    node_ptr_t &right();

    binary_tree<T> *parent();

    void insert(T data);

    struct iterator {
      public:
        iterator(binary_tree<T> *tree_ptr = nullptr);
        iterator(const iterator &iter); // copy constructor
        iterator(iterator &&iter);      // move constructor
        ~iterator();

        iterator &operator=(binary_tree<T> *tree_ptr);
        iterator &operator=(const iterator &iter_ref); // copy assignment op
        iterator &operator=(iterator &&iter_ref); // move assignment operator
        bool operator==(const iterator &rhs) const;
        bool operator!=(const iterator &rhs) const;
        iterator &operator++();
        T &operator*() const;
        const T *operator->() const;

      private:
        binary_tree<T> *_tree_ptr{nullptr};
    };

    auto begin() -> iterator;
    auto end() -> iterator;

  private:
    T _data{};
    node_ptr_t _left{nullptr};
    node_ptr_t _right{nullptr};
    binary_tree<T> *_parent{nullptr};
};

} // namespace binary_search_tree

/*
 * binary_search_tree - declarations
 */
namespace binary_search_tree {

/*
 * struct iterator definitions
 */

template <typename T>
binary_tree<T>::iterator::iterator(binary_tree<T> *tree_ptr)
    : _tree_ptr(tree_ptr) {}

template <typename T>
binary_tree<T>::iterator::iterator(const iterator &iter)
    : _tree_ptr(iter._tree_ptr) {}

template <typename T> binary_tree<T>::iterator::~iterator() = default;

template <typename T>
binary_tree<T>::iterator::iterator(iterator &&iter)
    : _tree_ptr(iter._tree_ptr) {}

template <typename T>
typename binary_tree<T>::iterator &
binary_tree<T>::iterator::operator=(binary_tree<T> *tree_ptr) {
    _tree_ptr = tree_ptr;

    return *this;
}

template <typename T>
typename binary_tree<T>::iterator &
// NOLINTNEXTLINE(bugprone-unhandled-self-assignment)
binary_tree<T>::iterator::operator=(const iterator &iter_ref) {
    // can't figure out how to verify that this isn't equal to *iter_ref
    _tree_ptr = iter_ref._tree_ptr;

    return *this;
}

template <typename T>
typename binary_tree<T>::iterator &
binary_tree<T>::iterator::operator=(iterator &&iter_ref) {
    (void)iter_ref;

    return *this;
}

template <typename T>
bool binary_tree<T>::iterator::operator==(const iterator &rhs) const {
    return _tree_ptr == rhs._tree_ptr;
}

template <typename T>
bool binary_tree<T>::iterator::operator!=(const iterator &rhs) const {
    return _tree_ptr != rhs._tree_ptr;
}

template <typename T>
typename binary_tree<T>::iterator &binary_tree<T>::iterator::operator++() {
    if (_tree_ptr->right()) {
        _tree_ptr = _tree_ptr->right()->begin()._tree_ptr;
    } else {
        binary_tree<T> *grandparent = _tree_ptr->parent();

        while (true) {
            if (grandparent && (grandparent->data() < _tree_ptr->data())) {
                grandparent = grandparent->parent();
            } else {
                _tree_ptr = grandparent;
                break;
            }
        }
    }

    return *this;
}

template <typename T> T &binary_tree<T>::iterator::operator*() const {
    return _tree_ptr->_data;
}

template <typename T> const T *binary_tree<T>::iterator::operator->() const {
    // const binary_search_tree::binary_tree<unsigned int>*
    return &(operator*());
}

/*
 * struct binary_tree definitions
 */

template <typename T> using node_ptr_t = std::unique_ptr<binary_tree<T>>;

template <typename T>
binary_tree<T>::binary_tree(T data, binary_tree<T> *parent)
    : _data(data), _left(nullptr), _right(nullptr), _parent(parent) {}

template <typename T>
binary_tree<T>::binary_tree(binary_tree &&tree) // move constructor
    : _data(tree._data) {}

template <typename T>
binary_tree<T>::binary_tree(const binary_tree &tree_ref) // copy constructor
    : _data(tree_ref._data) {}

template <typename T> binary_tree<T>::~binary_tree() = default;

template <typename T>
binary_tree<T> &binary_tree<T>::operator=(binary_tree &&tree_ref) {
    (void)tree_ref;

    return *this;
}

template <typename T>
binary_tree<T> &binary_tree<T>::operator=(binary_tree rhs) {
    _data = rhs._data;

    return *this;
}

template <typename T> bool binary_tree<T>::operator<(const binary_tree &rhs) {
    return _data < rhs._data;
}

template <typename T> T &binary_tree<T>::data() { return _data; }

template <typename T> node_ptr_t<T> &binary_tree<T>::left() { return _left; }

template <typename T> node_ptr_t<T> &binary_tree<T>::right() { return _right; }

template <typename T> binary_tree<T> *binary_tree<T>::parent() {
    return _parent;
}

// Note: The branches are "identical" because of their type, not true clones.
// There might be a less readable way of re-writing this, not looking for it.
// https://releases.llvm.org/11.0.0/tools/clang/tools/extra/docs/clang-tidy/checks/bugprone-branch-clone.html
template <typename T> void binary_tree<T>::insert(T data) {
    // NOLINTNEXTLINE(bugprone-branch-clone)
    if (_data < data) {
        // NOLINTNEXTLINE(bugprone-branch-clone)
        if (_right != nullptr) {
            _right->insert(data);
        } else {
            _right = node_ptr_t(new binary_tree<T>(data, this));
        }
    } else {
        // NOLINTNEXTLINE(bugprone-branch-clone)
        if (_left != nullptr) {
            _left->insert(data);
        } else {
            _left = node_ptr_t(new binary_tree<T>(data, this));
        }
    }
}

template <typename T> auto binary_tree<T>::begin() -> binary_tree<T>::iterator {
    return (_left) ? _left->begin() : binary_tree::iterator(this);
}

template <typename T> auto binary_tree<T>::end() -> binary_tree<T>::iterator {
    return iterator();
}

} // namespace binary_search_tree

#endif // BINARY_SEARCH_TREE_H
