#include "complex_numbers.hpp"

namespace complex_numbers {

// NOLINTNEXTLINE(bugprone-easily-swappable-parameters)
Complex::Complex(const double real, const double imag)
    : _real(real), _imag(imag) {}

double Complex::real() const { return _real; }

double Complex::imag() const { return _imag; }

double Complex::abs() const { return sqrt(pow(_real, 2) + pow(_imag, 2)); }

Complex Complex::conj() const { return {_real, -_imag}; }

Complex Complex::exp() const {
    const double real = std::exp(_real) * cos(_imag);
    const double imag = std::exp(_real) * sin(_imag);

    return {real, imag};
}

Complex Complex::operator+(const Complex &other) const {
    const double real = _real + other.real();
    const double imag = _imag + other.imag();

    return {real, imag};
}

Complex Complex::operator-(const Complex &other) const {
    const double real = _real - other.real();
    const double imag = _imag - other.imag();

    return {real, imag};
}

Complex Complex::operator*(const Complex &other) const {
    const double real1 = _real;
    const double imag1 = _imag;
    const double real2 = other.real();
    const double imag2 = other.imag();

    const double real = real1 * real2 - imag1 * imag2;
    const double imag = imag1 * real2 + real1 * imag2;

    return {real, imag};
}

Complex Complex::operator/(const Complex &other) const {
    const double real1 = _real;
    const double imag1 = _imag;
    const double real2 = other.real();
    const double imag2 = other.imag();

    const double denominator = (pow(real2, 2) + pow(imag2, 2));

    const double real = (real1 * real2 + imag1 * imag2) / denominator;
    const double imag = (imag1 * real2 - real1 * imag2) / denominator;

    return {real, imag};
}

} // namespace complex_numbers
