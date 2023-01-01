import 'dart:math';

class Point {
  final double x;
  final double y;
  final double distanceFromOrigin;

  Point(this.x, this.y): distanceFromOrigin = sqrt(x * x + y * y);
}

void main() {
  print(String.fromCharCode(195));
  var p = Point(2, 3);
  p=Point(9,40);
  print(p.distanceFromOrigin);
  print(p.x);
}