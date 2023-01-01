import 'dart:core';
import 'dart:io';
import 'dart:math';

class Operators {
  var k1 = String.fromCharCode(195);
  var k2 = String.fromCharCode(196);
  var k3 = String.fromCharCode(197);
  var k4 = String.fromCharCode(198);
  var k5 = String.fromCharCode(199);
  var memory = [];

  Operators(String exp) {
    var value = substitute(exp);
    memory = value.split('+');
    if (String.fromCharCode(exp.codeUnitAt(0)) == '-') {
      memory[0] = '-' + memory[0];
    }
  }

  String substitute(String va) {
    var val =
    (String.fromCharCode(va.codeUnitAt(0)) == '-') ? va.substring(1) : va;
    val = val
        .replaceAll('/-', k1)
        .replaceAll('*-', k2)
        .replaceAll('^-', k3)
        .replaceAll('E+', k4)
        .replaceAll('E-', k5)
        .replaceAll('-', '+-');
    return val;
  }

  String resubstitute(String va) {
    return va
        .replaceAll(k1, '/-')
        .replaceAll(k2, '*-')
        .replaceAll(k3, '^-')
        .replaceAll(k4, 'E+')
        .replaceAll(k5, 'E-');
  }

  double solve() {
    var finalValue = 0.0;
    for (String x in memory) {
      x = resubstitute(x);
      if (x.contains('*')) {
        x = multiply(x.split('*'));
      } else if (x.contains('/')) {
        x = divide(x.split('/'));
      } else if (x.contains('^')) {
        x = power(x.split('^'));
      }
      x = (x.contains('!')) ? factorial(x) : x;
      finalValue = finalValue + double.parse(x);
    }
    return finalValue;
  }

  String power(var split) {
    var finalValue = split[0].contains('!')
        ? num.parse(factorial(split[0]))
        : num.parse(split[0]);
    for (var i = 1; i < split.length; i++) {
      var x = split[i];
      x = (x.contains('!')) ? factorial(x) : x;
      finalValue = pow(finalValue, num.parse(x));
    }
    return finalValue.toString();
  }

  String divide(var split) {
    var finalValue = 1.0;
    for (var i = 0; i < split.length; i++) {
      var x = split[i];
      if (x.contains('^')) {
        x = power(x.split('^'));
      }
      x = (x.contains('!')) ? factorial(x) : x;
      finalValue = i == 0 ? double.parse(x) : finalValue / double.parse(x);
    }
    return finalValue.toString();
  }

  String multiply(var split) {
    var finalValue = 1.0;
    for (String x in split) {
      if (x.contains('/')) {
        x = divide(x.split('/'));
      } else if (x.contains('^')) {
        x = power(x.split('^'));
      }
      x = (x.contains('!')) ? factorial(x) : x;
      finalValue = finalValue * double.parse(x);
    }
    return finalValue.toString();
  }

  String factorial(String x) {
    while (x.contains('!')) {
      x = x.replaceAll(x.substring(0, x.indexOf('!') + 1),
          fac(BigInt.parse(x.substring(0, x.indexOf('!')))));
    }
    return x;
  }

  String fac(BigInt n) {
    return f(n).toString();
  }

  BigInt f(BigInt n) {
    return (n.compareTo(BigInt.one) > 0) ? (n * (f(n - BigInt.one))) : n;
  }
}

void main() {
  while (true) {
    String? s = stdin.readLineSync();
    try {
      var o = Operators(s!);
      print(o.solve());
    }
    catch(e) {
      throw "Bad expression";
    }
  }
}
