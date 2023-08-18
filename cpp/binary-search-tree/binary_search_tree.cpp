#include "binary_search_tree.h"

/*
 * Long story short: I guess I did make things harder on my self by insisting
 * that the proper way to write template was to separate definitions into the
 * cpp file and declarations into the hpp file.
 *
 * Apparently that's not how it should be done in C or C++. Figured that out at
 * the end when trying to figure out how to fix linking issues without including
 * the cpp file in the test source file.
 *
 * I still think this isn't the same type of "hard" difficulty level as the
 * other "hard" exercises in this track. Completing all the other exercises in
 * the C++ track before this one doesn't prepare you for it. Compared to the
 * rest of the exercises in the C++ track, this was a "nightmare" difficulty
 * level.
 *
 * I am glad I was stubborn about separating template declarations and
 * definitions. Learned a lot.
 *
 * There should have been a few
 * - create an interator for a vector exercises before this one.
 * - create a custom iterator for the node list you created in another exercise.
 * - create a generator/iterator
 * - better template exercises that help you learn about templates with classes
 * and structs instead of being a secondary mechanic thrown in there (a lot of
 * the solutions for those are also header file only solutions).
 *
 * Reference Material that helped me solve this with a cpp file with
 * definitions and a hpp (yes for soem weird reason they keep insisting on
 * using C header files in exercises or only a C++ source file) with only
 * declarations.
 *
 * Also using clang-check (well, only if I rename the header file from *.h to
 * *.hpp) and clang-tidy are a must. I had to restart with everything in the
 * header file, slowly split declarations and definitions in the header file
 * and then move the definitions to the source file. And then realizing one
 * isn't supposed to split template declarations and definitions into multiple
 * files. :)
 *
 * https://www.parashift.com/c++-faq-lite/templates.html
 * https://isocpp.org/wiki/faq/templates
 * https://en.cppreference.com/w/cpp/language/rule_of_three
 * https://en.cppreference.com/w/cpp/language/move_assignment
 * https://en.cppreference.com/w/cpp/language/move_constructor
 * https://en.cppreference.com/w/cpp/language/copy_constructor
 * https://en.cppreference.com/w/cpp/language/copy_assignment
 * https://en.cppreference.com/w/cpp/language/operators
 *
 * https://stackoverflow.com/questions/1575181/why-does-the-operator-work-on-structs-without-having-been-defined
 * https://stackoverflow.com/questions/3008541/template-class-symbols-not-found
 * https://stackoverflow.com/questions/48422601/why-must-i-declare-copy-move-constructors-when-declaring-destructors
 * https://stackoverflow.com/questions/14047191/overloading-operators-in-typedef-structs-c
 * https://stackoverflow.com/questions/4505090/linking-templates-with-g
 * https://stackoverflow.com/questions/115703/storing-c-template-function-definitions-in-a-cpp-file
 *
 * Side note: please rename all the C *.h header files to C++ *.hpp header
 * files. The contents of the files aren't valid C, so I don't get why they're
 * still using C header file extensions. Don't remove them. There's a lot to be
 * learned from splitting up declarations and definitions into two separate
 * files.
 *
 * The only way I can keep the definitions in the cpp file is if the test file
 * includes the cpp file which isn't ideal. So moving the definitions back into
 * the header file but keeping them separate because I find that easier to read
 * and maintain.
 */

/* this is only needed if the definitions are in this file

template struct binary_search_tree::binary_tree<
    binary_search_tree::binary_tree<unsigned int>>;

template struct binary_search_tree::binary_tree<
    binary_search_tree::binary_tree<std::string>>;

*/

namespace binary_search_tree {} // namespace binary_search_tree
