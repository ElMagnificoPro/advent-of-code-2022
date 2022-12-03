import 'dart:io';

void main(List<String> args) {
  List input = File('day 3.txt').readAsStringSync().split('\r\n');

  String letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

  // part 1

  var part1 = [];

  input
      .map((e) => [e.substring(0, e.length ~/ 2), e.substring(e.length ~/ 2)])
      .toList()
      .forEach((e) {
    for (var i = 0; i < e[0].length; i++) {
      var found = e[1].indexOf(e[0][i]);
      if (found >= 0) {
        part1.add(letters.indexOf(e[1][found]) + 1);
        return;
      }
    }
  });

  print('part 1 : ${part1.reduce((value, element) => value + element)}');

// part 2

  var part2 = [];

  for (var i = 0; i < input.length - 2; i += 3) {
    for (var j = 0; j < input[i].length; j++) {
      var index1 = input[i + 1].indexOf(input[i][j]);
      var index2 = input[i + 2].indexOf(input[i][j]);

      if (index1 >= 0 && index2 >= 0) {
        part2.add(letters.indexOf(input[i][j]) + 1);
        break;
      }
    }
  }

  print('part 2 : ${part2.reduce((value, element) => value + element)}');
}
