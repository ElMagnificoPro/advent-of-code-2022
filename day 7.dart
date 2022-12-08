import 'dart:io';

void main() {
  var input = new Map();
  var path = [];

  File('day 7.txt').readAsStringSync().split('\r\n').forEach((e) {
    if (e == '\$ cd ..') {
      path.removeLast();
    } else if (e.contains('\$ cd ')) {
      path.add(e.substring(5));
    } else if (int.tryParse(e[0]) != null) {
      for (var i = 0; i < path.length; i++) {
        var currentDir = path.take(i + 1).join('/');
        if (input[currentDir] == null) {
          input[currentDir] = 0;
        }
        input[currentDir] += int.tryParse(e.split(' ')[0]);
      }
    }
/*
    print(e);
    print(path);
    print(input);
    print('--------------------');
    */
  });

  var part1 = input.entries
      .map((e) => e.value)
      .where((value) => value < 100000)
      .fold<int>(0, (previousValue, element) => previousValue + element as int);
  var part2 = input.entries
      .map((e) => e.value)
      .where((value) => input['/'] - value < 40000000)
      .toList();
  part2.sort();

  print('part 1 : $part1');

  print('part 2 : ${part2[0]}');
}
