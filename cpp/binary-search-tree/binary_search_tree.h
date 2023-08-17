#if !defined(BINARY_SEARCH_TREE_H)
#define BINARY_SEARCH_TREE_H

#include<iterator>
#include<memory>
#include<string>

namespace binary_search_tree {

template <typename T>
struct binary_tree {
    public:
        using tree_ptr_t = std::unique_ptr<binary_tree<T>>;
        using parent_t = tree_ptr_t*;
        using iter_t = std::input_iterator_tag;

        // binary_tree()  = default;
        ~binary_tree() = default;

        binary_tree(const T& data);
        binary_tree(T& data, const bool& is_right = false, const bool& is_left = false);

        /*
        binary_tree(T& data, parent_t parent = nullptr, const bool& is_right = false, const bool& is_left = false);
        binary_tree(T data, parent_t parent = nullptr, const bool& is_right = false, const bool& is_left = false);
        binary_tree(T &data, parent_t parent = nullptr);
        binary_tree(T data, parent_t parent = nullptr);
        */

        binary_tree(std::initializer_list<T> data);

        [[nodiscard]] T &data() ;

        [[nodiscard]] tree_ptr_t & parent() ;
        [[nodiscard]] tree_ptr_t & left() ;
        [[nodiscard]] tree_ptr_t & right() ;

        void insert(T new_data);

        struct iterator {
            public:
                iterator(tree_ptr_t tree_ptr);
                iterator(const iterator& iter);

                [[nodiscard]] bool operator==(const iterator& rhs) const;
                [[nodiscard]] bool operator!=(const iterator& rhs) const;
                tree_ptr_t & operator++() ;
                auto operator*() -> const iterator&;
                auto operator->() -> const T*;

            private:
                tree_ptr_t _tree_ptr{nullptr};
        };

        auto begin() -> iterator;
        auto end() -> iterator;

    private:
        T _data{};

        binary_tree<T>* _parent{nullptr};
        tree_ptr_t _left{nullptr};
        tree_ptr_t _right{nullptr};

        bool _is_left{false};
        bool _is_right{false};
};

    template <typename T>
    using tree_ptr_t = std::unique_ptr<binary_tree<T>>;

    template <typename T>
    binary_tree<T>::binary_tree(const T& data):
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
    T &binary_tree<T>::data() {
        return _data;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::parent() {
        return _parent;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::left() {
        return _left;
    }

    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::right() {
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
    binary_tree<T>::iterator::iterator(tree_ptr_t tree_ptr):
        _tree_ptr(tree_ptr) {}

    template <typename T>
    binary_tree<T>::iterator::iterator(const iterator& iter):
        _tree_ptr(iter.tree_ptr) {}

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
        // return &(operator*());
        if(_tree_ptr->right() != nullptr) {
            _tree_ptr = _tree_ptr->right()->begin._tree_ptr;
        } else {
            binary_tree<T>* top{ _tree_ptr->parent()};
            while(true) {
                if(top && (top->data() < _tree_ptr->data())) {
                    top = top->parent();
                } else {
                    _tree_ptr = top;

                    break;
                }
            }
        }
    }
}  // namespace binary_search_tree

#endif // BINARY_SEARCH_TREE_H
