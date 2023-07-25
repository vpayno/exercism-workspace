#if !defined(ALL_YOUR_BASE_H)
#define ALL_YOUR_BASE_H

#include <algorithm>
#include <numeric>
#include <stdexcept>
#include <string>
#include <vector>

namespace all_your_base {

struct compare {
  public:
    compare(unsigned int const &value) : base(value) {}

    bool operator()(unsigned int const &value) const { return (value >= base); }

  private:
    unsigned int base;
};

std::vector<unsigned int> convert(unsigned int input_base,
                                  std::vector<unsigned int> input_sequence,
                                  unsigned int output_base);

} // namespace all_your_base

#endif // ALL_YOUR_BASE_H
