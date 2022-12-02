import 'dart:io';

int play1(String p1, String p2) {
  Map<String, int> values = {'A': 1, 'B': 2, 'C': 3, 'X': 1, 'Y': 2, 'Z': 3};

  if (values[p1] == values[p2]) {
    return values[p2]! + 3;
  } else if ((values[p1]! - values[p2]!) % 3 == 1) {
    return values[p2]!;
  } else {
    return values[p2]! + 6;
  }
}

int play2(String p1, String p2) {
  Map<String, int> values = {'A': 1, 'B': 2, 'C': 3, 'X': 1, 'Y': 2, 'Z': 3};

  if (values[p2] == 2) {
    return values[p1]! + 3;
  } else if (values[p2] == 1) {
    return (values[p1]! - 1 < 1) ? 3 : values[p1]! - 1;
  } else {
    return (values[p1]! + 1 > 3) ? 1 + 6 : values[p1]! + 1 + 6;
  }
}

void main() {
  String test = "A Y\r\nB X\r\nC Z";
  var input = File('day 2.txt').readAsStringSync().split('\r\n');
  //var input = test.split('\r\n');
  var part1 = [];
  var part2 = [];

  input.map((e) => e.split(' ')).forEach((e) {
    part1.add(play1(e[0], e[1]));
  });
  input.map((e) => e.split(' ')).forEach((e) {
    part2.add(play2(e[0], e[1]));
  });

  print("part 1 : ${part1.reduce((value, element) => value + element)}");
  print("part 2 : ${part2.reduce((value, element) => value + element)}");
}
