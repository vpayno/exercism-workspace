// This is a C++ Header file (*.hpp)

// This is an include guard.
// You could alternatively use '#pragma once'
// See https://en.wikipedia.org/wiki/Include_guard
#if !defined(HELLO_WORLD_HPP)
#define HELLO_WORLD_HPP

// Include the string header so that we have access to 'std::string'
#include <string>

// Declare a namespace for the function(s) we are exporting.
// https://en.cppreference.com/w/cpp/language/namespace
namespace hello_world {

// Using a named type to help with code readability.
// https://en.cppreference.com/w/cpp/keyword/using
using message_t = std::string;

// Declare the 'hello()' function, which takes no arguments and returns a
// 'message_t'. The function itself is defined in the hello_world.cpp source
// file. Because it is inside of the 'hello_world' namespace, it's full name is
// 'hello_world::hello()'.
message_t hello();

} // namespace hello_world

#endif // HELLO_WORLD_HPP
