#include "triangle.h"

bool is_triangle(triangle_t triangle) {
    if (triangle.a <= 0 && triangle.b <= 0 && triangle.c <= 0) {
        return false;
    }

    if ((triangle.a + triangle.b) >= triangle.c &&
        (triangle.a + triangle.c) >= triangle.b &&
        (triangle.b + triangle.c) >= triangle.a) {
        return true;
    }

    return false;
}

bool is_equilateral(triangle_t triangle) {
    if (!is_triangle(triangle)) {
        return false;
    }

    if (triangle.a == triangle.b && triangle.a == triangle.c) {
        return true;
    }

    return false;
}

bool is_isosceles(triangle_t triangle) {
    if (!is_triangle(triangle)) {
        return false;
    }

    if (is_equilateral(triangle)) {
        return true;
    }

    if ((triangle.a == triangle.b && triangle.a != triangle.c) ||
        (triangle.b == triangle.c && triangle.b != triangle.a) ||
        (triangle.a == triangle.c && triangle.a != triangle.b)) {
        return true;
    }

    return false;
}

bool is_scalene(triangle_t triangle) {
    if (!is_triangle(triangle)) {
        return false;
    }

    if (triangle.a != triangle.b && triangle.a != triangle.c &&
        triangle.b != triangle.c) {
        return true;
    }

    return false;
}
