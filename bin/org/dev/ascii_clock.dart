import 'dart:async';
import 'dart:io';
import 'dart:math';

void main() async {
  const double R = 2, c_r = 0.6, r = 1.5;
  DateTime now = DateTime.now();
  String formattedTime = "${now.hour % 12}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  Point sec = Point(R, R - c_r);
  Point min = Point(R, R - c_r);
  Point hou = Point(R, R - c_r);
  sec = rotate(now.second * -6, Point(R, R), Point(R, R - c_r));

  while (true) {
    final startTime = DateTime.now();
    now = DateTime.now();
    formattedTime = "${now.hour % 12}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    min = rotate(now.minute * -6, Point(R, R), Point(R, R - c_r));
    hou = rotate(now.hour * -30, Point(R, R), Point(R, R - 0.4));

    StringBuffer s = StringBuffer();
    double X_s = sec.x, Y_s = sec.y;
    double X_m = min.x, Y_m = min.y;
    double X_h = hou.x, Y_h = hou.y;

    for (double y = 0; y < 2 * R; y += 0.01) {
      for (double x = 0; x < 2 * R; x += 0.01) {
        bool I = isOutsideCircle(Point(x, y), r, Point(R, R));
        bool K = isInsideCircle(Point(x, y), R, Point(R, R));
        bool S = isInsideCircle(Point(x, y), c_r, Point(X_s, Y_s));
        bool M = isInsideCircle(Point(x, y), c_r, Point(X_m, Y_m));
        bool H = isInsideCircle(Point(x, y), 0.4, Point(X_h, Y_h));
        bool line_s = Line(Point(R, R), Point(X_s, Y_s)).contains(Point(x, y));
        bool line_m = Line(Point(R, R), Point(X_m, Y_m)).contains(Point(x, y));
        bool line_h = Line(Point(R, R), Point(X_h, Y_h)).contains(Point(x, y));

        if ((K && I) && false) {
          s.write('\x1B[0;96m██\x1B[0m');
        } else if (line_s && S) {
          s.write('\x1B[0;32m██\x1B[0m');
        } else if (line_m && M) {
          s.write('\x1B[0;33m██\x1B[0m');
        } else if (line_h && H) {
          s.write('\x1B[0;31m██\x1B[0m');
        } else if (isInsideCircle(Point(x, y), r, Point(R, R)) &&
            isOutsideCircle(Point(x, y), r - 0.1, Point(R, R))) {
          int tick = calculateAngleInDegree(Point(R, R), Point(x, y)).round();
          if (tick % 30 == 0) {
            s.write('\x1B[0;31m██\x1B[0m');
          } else {
            s.write('  ');
          }
        } else {
          s.write('  ');
        }
      }
      s.write('\n');
    }

    stdout.write('\x1B[H'); // Move cursor to top-left
    stdout.write(s.toString());
    sec = rotate(-6, Point(R, R), sec);

    final endTime = DateTime.now();
    final elapsed = endTime.difference(startTime).inMilliseconds;
    await Future.delayed(Duration(milliseconds: 1000 - elapsed));
  }
}

bool isInsideCircle(Point point, double radius, Point center) {
  return calculateCircle(point, radius, center) <= 0;
}

bool isOutsideCircle(Point point, double radius, Point center) {
  return calculateCircle(point, radius, center) > 0;
}

double calculateCircle(Point point, double r, Point center) {
  return point.y * point.y +
      point.x * point.x +
      center.x * center.x +
      center.y * center.y -
      2 * center.x * point.x -
      2 * center.y * point.y -
      r * r;
}

Point rotate(double angle, Point center, Point point) {
  angle = angle * pi / 180.0;
  double x = point.x;
  double y = point.y;
  double X = center.x;
  double Y = center.y;
  double arg = atan2(y - Y, x - X);
  double d = arg - angle;
  double sqr = sqrt((X - x) * (X - x) + (Y - y) * (Y - y));
  return Point(center.x + (sqr * cos(d)), center.y + (sqr * sin(d)));
}

double calculateAngleInDegree(Point center, Point point) {
  double x = point.x;
  double y = point.y;
  double X = center.x;
  double Y = center.y;
  double arg = atan2(y - Y, x - X);
  return arg * 180.0 / pi;
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  @override
  String toString() {
    return 'Point{x: $x, y: $y}';
  }
}

class Line {
  final Point point;
  final double slope;

  Line(this.point, Point point2)
      : slope = (point2.y - point.y) / (point2.x - point.x);

  @override
  String toString() {
    return 'Line [${slope}x-y${-slope * point.x + point.y}]';
  }

  bool contains(Point point) {
    if ((slope.isInfinite || slope.isNaN) && ((this.point.x - point.x).abs() <= 0.01)) {
      return true;
    }
    return (point.y - this.point.y == slope * (point.x - this.point.x)) ||
        ((point.y - this.point.y) - slope * (point.x - this.point.x)).abs() <= 0.01;
  }
}