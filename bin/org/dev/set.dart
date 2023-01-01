import 'dart:math';

void main() {
  final constantSet = const {
    'fluorine',
    'chlorine',
    'bromine',
    'iodine',
    'astatine',
  };
  print(constantSet);
  print(say('hilal', 'anwar', 'jkbjkbkjbkjbkb'));
  enableFlags(bold: true);
  doStuff();
  var loudify = (msg, value) => [msg = msg.toUpperCase(), msg = value + msg];
  var fun = (v) {
    print('Hello ' + v);
    return 'How are you ?';
  };
  print(loudify('58', '69').runtimeType);
  print(fun('helal').runtimeType);
}

void enableFlags({bool? bold, bool? hidden}) {
  print(bold);
  print(hidden);
}

String say(String from, String msg, [String device = 'carrier pigeon']) {
  print(device);
  var result = '$from says $msg with a $device';
  return result;
}

void doStuff(
    {List<int>? list = const [1, 2, 3],
    Map<String, String>? gifts = const {
      'first': 'paper',
      'second': 'cotton',
      'third': 'leather'
    }}) {
  print('list:  $list');
  print('gifts: $gifts');
}

bool is_pronic_number(var n) {
  var a = 2 * sqrt(n + 0.25);
  var b = (a + 1) * 0.5;
  return b - b.toInt() == 0 && b * (b - 1) == n;
}
