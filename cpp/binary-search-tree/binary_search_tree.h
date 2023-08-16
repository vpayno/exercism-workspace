#if !defined(BINARY_SEARCH_TREE_H)
#define BINARY_SEARCH_TREE_H

#include<iterator>
#include<memory>
#include<vector>

namespace binary_search_tree {

template <typename T>
struct binary_tree {
    public:
        using tree_ptr_t = std::unique_ptr<binary_tree<T>>;
        using parent_t = tree_ptr_t*;
        using iter_t = std::input_iterator_tag;

        // binary_tree()  = default;
        // ~binary_tree() = default;

        binary_tree(T data);
        binary_tree(T& data, const bool& is_right = false, const bool& is_left = false);

        /*
        binary_tree(T& data, parent_t parent = nullptr, const bool& is_right = false, const bool& is_left = false);
        binary_tree(T data, parent_t parent = nullptr, const bool& is_right = false, const bool& is_left = false);
        binary_tree(T &data, parent_t parent = nullptr);
        binary_tree(T data, parent_t parent = nullptr);
        */

        binary_tree(std::initializer_list<T> data);

        [[nodiscard]] T data() const;

        [[nodiscard]] tree_ptr_t & parent() const;
        [[nodiscard]] tree_ptr_t & left() const;
        [[nodiscard]] tree_ptr_t & right() const;

        void insert(T new_data);

        struct iterator {
            public:
                iterator(tree_ptr_t tree_ptr);

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
        auto cbegin() -> iterator;
        auto cend() -> iterator;

    private:
        T _data{};

        tree_ptr_t _parent{nullptr};
        tree_ptr_t _left{nullptr};
        tree_ptr_t _right{nullptr};

        bool _is_left{false};
        bool _is_right{false};
};

}  // namespace binary_search_tree

#endif // BINARY_SEARCH_TREE_H
