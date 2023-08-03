// Determine if a triangle is equilateral, isosceles or scalene.
// https://exercism.org/tracks/dart/exercises/triangle
class Triangle {
  bool equilateral(double a, double b, double c) {
    return a == b && a == c;
  }

  bool isosceles(double a, double b, double c) {
    return (a == b && a != c) || (b == c && b != a) || (a == c && a != b);
  }

  bool scalene(double a, double b, double c) {
    return a != b && a != c && b != c;
  }
}
