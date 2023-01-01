import '../complex/Complex.dart';

class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
void main(){
  var x=const ImmutablePoint(55,63);
  var y=const ImmutablePoint(55,63);
  print(ImmutablePoint.origin);
  print(x==y);
}