#if !defined(ALL_YOUR_BASE_HPP)
#define ALL_YOUR_BASE_HPP

#include <vector>

namespace all_your_base {

std::vector<unsigned int> convert(unsigned int input_base,
                                  std::vector<unsigned int> input_sequence,
                                  unsigned int output_base);

} // namespace all_your_base

#endif // ALL_YOUR_BASE_HPP
