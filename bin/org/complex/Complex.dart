import 'dart:math';

class Complex {
  double real;
  double imaginary;
  static const int x=10;
  Complex(this.real, this.imaginary);
  double modulus() {
    return sqrt(real * real + imaginary * imaginary);
  }
  Complex conjugate() {
    return Complex(real, -1 * imaginary);
  }

  @override
  String toString() {
    return 'Complex{real: $real, imaginary: $imaginary}';
  }

  Complex add(Complex number) {
    return Complex((real + number.real), (imaginary + number.imaginary));
  }

  Complex subtract(Complex number) {
    return Complex((real - number.real), (imaginary - number.imaginary));
  }

  Complex product(Complex number) {
    return Complex((real * number.real - imaginary * number.imaginary),
        (real * number.imaginary + imaginary * number.real));
  }

  Complex division(Complex number) {
    return Complex(product(number.conjugate()).real / pow(number.modulus(), 2),
        product(number.conjugate()).imaginary / pow(number.modulus(), 2));
  }

  Complex inverse() {
    return Complex(1, 0).division(this);
  }

  Complex power(int pow) {
    var p = Complex(1, 0);
    var k = this;
    if (pow >= 1) {
      while (pow >= 1) {
        if (pow % 2 == 0) {
          k = k.product(this);
          pow = (pow ~/ 2);
        } else {
          p = p.product(k);
          pow--;
        }
      }
    } else {
      return power(pow * -1).inverse();
    }
    return p;
  }
}
