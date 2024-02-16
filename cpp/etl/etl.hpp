#if !defined(ETL_HPP)
#define ETL_HPP

#include <map>
#include <vector>

namespace etl {

using score_t = int;
using letter_t = char;
using old_format_t = std::map<score_t, std::vector<letter_t>>;
using new_format_t = std::map<letter_t, score_t>;

new_format_t transform(old_format_t old_format);

} // namespace etl

#endif // ETL_HPP
