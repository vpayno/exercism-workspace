#if !defined(COMPLEX_NUMBERS_H)
#define COMPLEX_NUMBERS_H

#include <cmath>

namespace complex_numbers {

struct Complex {
  public:
    Complex() = delete;
    Complex(double real, double imag);

    [[nodiscard]] double real() const;
    [[nodiscard]] double imag() const;
    [[nodiscard]] double abs() const;

    [[nodiscard]] Complex conj() const;
    [[nodiscard]] Complex exp() const;

    Complex operator+(const Complex &other) const;
    Complex operator-(const Complex &other) const;
    Complex operator*(const Complex &other) const;
    Complex operator/(const Complex &other) const;

  private:
    double _real;
    double _imag;
};

} // namespace complex_numbers

#endif // COMPLEX_NUMBERS_H
