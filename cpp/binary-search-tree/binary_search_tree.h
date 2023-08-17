#if !defined(BINARY_SEARCH_TREE_H)
#define BINARY_SEARCH_TREE_H

#include<memory>
#include<string>
#include<vector>

namespace binary_search_tree {

template <typename T>
using vector_iter_t = typename std::vector<T>::iterator;

template <typename T>
struct binary_tree {
    public:
        using tree_ptr_t = std::unique_ptr<binary_tree<T>>;
        using parent_t = tree_ptr_t*;

        binary_tree() = delete;
        // binary_tree()  = default;
        ~binary_tree() = delete;

        // binary_search_tree::binary_tree<unsigned int>
        binary_tree(T data);
        // binary_tree(T& data, const bool& is_right = false, const bool& is_left = false);

        binary_tree(std::initializer_list<T> data);

        binary_tree(binary_tree&& copy);

        [[nodiscard]] T data() const;

        // [[nodiscard]] tree_ptr_t & parent() const;
        [[nodiscard]] tree_ptr_t & left() const;
        [[nodiscard]] tree_ptr_t & right() const;

        void insert(T new_data);

        auto begin() -> vector_iter_t<T>;
        auto end() -> vector_iter_t<T>;

        /*
        binary_tree& operator=(binary_tree const& copy);
        binary_tree& operator=(std::initializer_list<T> copy);
        binary_tree& operator=(binary_tree&& copy);
        */

    private:
        T _data{};
        std::vector<T> _vector{};

        // tree_ptr_t _parent{nullptr};
        tree_ptr_t _left{nullptr};
        tree_ptr_t _right{nullptr};

        bool _is_left{false};
        bool _is_right{false};
};

    template <typename T>
    using tree_ptr_t = std::unique_ptr<binary_tree<T>>;

    template <typename T>
    binary_tree<T>::binary_tree(const T data):
        _data(std::move(data)) {}

    // new binary_search_tree::binary_tree<T>(*data_iter));
    template <typename T>
    binary_tree<T>::binary_tree(std::initializer_list<T> data) {
        for(auto iter=data.begin(); iter != data.end(); iter++) {
            insert(*iter);
        }
    }

    template <typename T>
    binary_tree<T>::binary_tree(binary_tree&& copy):
        binary_tree(std::move(copy))
    {}

    /*
    template <typename T>
    // NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
    binary_tree<T>::binary_tree(T& data, const bool& is_right, const bool& is_left):
        _data(data),
        _right(is_right),
        _left(is_left)
    {}
    */

    template <typename T>
    T binary_tree<T>::data() const {
        return _data;
    }

    /*
    template <typename T>
    tree_ptr_t<T> & binary_tree<T>::parent() const {
        return _parent;
    }
    */

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
                _left = std::make_unique<tree_ptr_t>(new_data);
            } else {
                _left->insert(new_data);
            }
        } else {
            if(_right == nullptr) {
                _right = std::make_unique<tree_ptr_t>(new_data);
            } else {
                _right->insert(new_data);
            }
        }
    }

    /*
    template <typename T>
    binary_tree<T>& binary_tree<T>::operator=(binary_tree const& copy) {
        operator=(copy);

        _data = copy.data();
        _left = copy.left();
        _right = copy.right();

        return *this;
    }

    template <typename T>
    binary_tree<T>& binary_tree<T>::operator=(std::initializer_list<T> copy) {
        operator=(copy);

        _vector = copy;

        return *this;
    }

    template <typename T>
    binary_tree<T>& binary_tree<T>::operator=(binary_tree<T>&& copy) {
        operator=(std::move(copy));

        _data = std::move(copy.data());
        _left = std::move(copy.left());
        _right = std::move(copy.right());

        return *this;
    }
    */

    template <typename T>
    auto binary_tree<T>::begin() -> vector_iter_t<T> {
        return _vector.begin();
    }

    template <typename T>
    auto binary_tree<T>::end() -> vector_iter_t<T> {
        return _vector.end();
    }

}  // namespace binary_search_tree

#endif // BINARY_SEARCH_TREE_H
