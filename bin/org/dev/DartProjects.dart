import '../complex/Complex.dart';
import 'Spacecraft.dart';

void main(List<String> arguments) {
  print('Hello world!');
  const Object i=3;
  const num='123';
  const e=[];
  const map = {if (i is int) i: 'int'};
  print(map);
  const list = [i as int]; // Use a typecast.
  print(list);
  const set = {if (list is List<int>) ...list};
  print(set);
  var x=Spacecraft('Apollo 11', DateTime.parse('2009-05-12'));
  x.describe();
  print(Spacecraft.unlaunched('Boeing 746'));
  var y=Complex(5, 5);
  print(y.add(Complex(2, 3)).real);
  printWithDelay('hello world from dart !');
}
Future<void> printWithDelay(String message) async {
  const oneSecond = Duration(seconds: 1);
  await Future.delayed(oneSecond);
  print(message);
}