#if !defined(ISBN_VERIFIER_H)
#define ISBN_VERIFIER_H

// this isn't a c++ header file

#include <numeric>
#include <regex>
#include <string>

namespace isbn_verifier {

using isbn_number_t = std::string;

bool is_valid(isbn_number_t number);

} // namespace isbn_verifier

#endif // ISBN_VERIFIER_H
