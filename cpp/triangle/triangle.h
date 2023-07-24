#if !defined(TRIANGLE_H)
#define TRIANGLE_H

#include <stdexcept>

namespace triangle {

enum class flavor {
    equilateral,
    isosceles,
    scalene,
};

flavor kind(double side_a, double side_b, double side_c);

bool is_triangle(double side_a, double side_b, double side_c);
bool is_equilateral(double side_a, double side_b, double side_c);
bool is_isosceles(double side_a, double side_b, double side_c);
bool is_scalene(double side_a, double side_b, double side_c);

} // namespace triangle

#endif // TRIANGLE_H
