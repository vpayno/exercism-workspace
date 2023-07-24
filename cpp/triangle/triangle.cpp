#include "triangle.hpp"

namespace triangle {

flavor kind(double side_a, double side_b, double side_c) {
    if (!is_triangle(side_a, side_b, side_c)) {
        throw std::domain_error{"not a triangle"};
    }

    if (is_equilateral(side_a, side_b, side_c)) {
        return flavor::equilateral;
    }

    if (is_isosceles(side_a, side_b, side_c)) {
        return flavor::isosceles;
    }

    if (is_scalene(side_a, side_b, side_c)) {
        return flavor::scalene;
    }

    // I know this doesn't get used.
    return flavor::scalene;
}

bool is_triangle(double side_a, double side_b, double side_c) {
    if (side_a <= 0 or side_b <= 0 or side_c <= 0) {
        return false;
    }

    if ((side_a + side_b) >= side_c && (side_a + side_c) >= side_b &&
        (side_b + side_c) >= side_a) {
        return true;
    }

    return false;
}

bool is_equilateral(double side_a, double side_b, double side_c) {
    return side_a == side_b && side_a == side_c;
}

bool is_isosceles(double side_a, double side_b, double side_c) {
    return (side_a == side_b && side_a != side_c) ||
           (side_b == side_c && side_b != side_a) ||
           (side_a == side_c && side_a != side_b);
}

bool is_scalene(double side_a, double side_b, double side_c) {
    return side_a != side_b && side_a != side_c && side_b != side_c;
}

} // namespace triangle
