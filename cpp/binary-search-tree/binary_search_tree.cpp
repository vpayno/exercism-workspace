#include "binary_search_tree.h"

template struct binary_search_tree::binary_tree<binary_search_tree::binary_tree<int>::tree_ptr_t>;

namespace binary_search_tree {

    template <typename T>
    using tree_ptr_t = std::unique_ptr<binary_tree<T>>;

    template <typename T>
    binary_tree<T>::binary_tree(T data):
        _data(std::move(data)) {}

    template <typename T>
    binary_tree<T>::binary_tree(std::initializer_list<T> data) {
        for(auto iter=data.begin(); iter != data.end(); iter++) {
            insert(*iter);
        }
    }

    template <typename T>
    // NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
    binary_tree<T>::binary_tree(T& data, const bool& is_right, const bool& is_left):
        _data(data),
        _parent(parent),
        _right(is_right),
        _left(is_left)
    {}

    /*
    template <typename T>
    // NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
    binary_tree<T>::binary_tree(T data, parent_t parent, const bool& is_right, const bool& is_left):
        _data(data),
        _parent(parent),
        _right(is_right),
        _left(is_left)
    {}

    template <typename T>
    binary_tree<T>::binary_tree(T &data, parent_t parent):
        _data(data),
        _parent(parent)
    {}

    template <typename T>
    binary_tree<T>::binary_tree(T data, parent_t parent):
        _data(data),
        _parent(parent)
    {}
    */

    template <typename T>
    T binary_tree<T>::data() const {
        return _data;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::parent() const {
        return _parent;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::left() const {
        return _left;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::right() const {
        return _right;
    }

    template <typename T>
    void binary_tree<T>::insert(T new_data) {
        if(new_data <= _data) {
            if(_left == nullptr) {
                _left = std::make_unique<tree_ptr_t>(new_data, this, false, true);
            } else {
                _left->insert(new_data);
            }
        } else {
            if(_right == nullptr) {
                _right = std::make_unique<tree_ptr_t>(new_data, this, false, true);
            } else {
                _right->insert(new_data);
            }
        }
    }

    template <typename T>
    auto binary_tree<T>::begin() -> binary_tree<T>::iterator {
        return (_left != nullptr) ? _left->begin() : iterator { this };
    }

    template <typename T>
    auto binary_tree<T>::end() -> binary_tree<T>::iterator {
        return iterator { nullptr };
    }

    template <typename T>
    auto binary_tree<T>::begin() -> binary_tree<T>::iterator {
        return (_left != nullptr) ? _left->begin() : iterator { this };
    }

    template <typename T>
    auto binary_tree<T>::end() -> binary_tree<T>::iterator {
        return iterator { nullptr };
    }

    template <typename T>
    auto binary_tree<T>::cbegin() -> binary_tree<T>::iterator {
        return (_left != nullptr) ? _left->begin() : iterator { this };
    }

    template <typename T>
    auto binary_tree<T>::cend() -> binary_tree<T>::iterator {
        return iterator { nullptr };
    }

    template <typename T>
    binary_tree<T>::iterator::iterator(tree_ptr_t tree_ptr):
        _tree_ptr(tree_ptr) {}

    template <typename T>
    bool binary_tree<T>::iterator::operator==(const iterator& rhs) const{
        return _tree_ptr == rhs._tree_ptr;
    }

    template <typename T>
    bool binary_tree<T>::iterator::operator!=(const iterator& rhs) const {
        return _tree_ptr != rhs._tree_ptr;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::iterator::operator++() {
        _tree_ptr = _tree_ptr->next();

        return *this;
    }

    template <typename T>
    auto binary_tree<T>::iterator::operator*() -> const binary_tree<T>::iterator &{
        return _tree_ptr->_data;
    }

    template <typename T>
    auto binary_tree<T>::iterator::operator->() -> const T* {
        return &(operator*());
    }

}  // namespace binary_search_tree
